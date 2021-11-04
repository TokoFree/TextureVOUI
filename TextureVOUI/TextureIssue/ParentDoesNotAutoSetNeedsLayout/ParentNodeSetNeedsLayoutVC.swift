//
//  ParentNodeSetNeedsLayoutVC.swift
//  TextureVOUI
//
//  Created by Jefferson Setiawan on 17/09/21.
//

import AsyncDisplayKit

class ParentNodeSetNeedsLayoutVC: ASDKViewController<ASDisplayNode> {
    private let titleNode: ASTextNode2 = {
        let textNode = ASTextNode2()
        textNode.attributedText = .init(string: "You can try switching the chip from 2 to 6 to reproduce the bug. When 2 is selected, the '2' has promo, when 6 is selected, the '2' will not have promo.")
        
        return textNode
    }()
    private var chipNodes: [ChipNode] = []
    
    private var chipsData: [ChipModel] = [
        ChipModel(optionId: 1, title: "2", isSelected: true, isCampaign: true),
        ChipModel(optionId: 2, title: "4", isSelected: false, isCampaign: false),
        ChipModel(optionId: 3, title: "6", isSelected: false, isCampaign: true),
    ]
    
    override init() {
        let rootNode = ASDisplayNode()
        super.init(node: rootNode)
        chipDidTap(2)
        chipNodes = chipsData.enumerated().map { [unowned self] index, data in
            let node = ChipNode(data: data)
            node.didTap = {
                self.chipDidTap(index)
            }
            return node
        }
        rootNode.backgroundColor = .white
        rootNode.automaticallyManagesSubnodes = true
        rootNode.layoutSpecBlock = { [unowned self] _, _ in
            let chipStack = ASStackLayoutSpec.horizontal()
            chipStack.children = chipNodes
            chipStack.spacing = 8
            let vStack = ASStackLayoutSpec.vertical()
            vStack.spacing = 16
            vStack.children = [titleNode, chipStack]
            return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 8, left: 8, bottom: 0, right: 8), child: vStack)
        }
    }
    
    private func chipDidTap(_ index: Int) {
        for i in 0..<chipsData.count {
            chipsData[i].isSelected = index == i
        }
        if index == 0 {
            chipsData[0].isCampaign = true
        } else if index == 2 {
            chipsData[0].isCampaign = false
        }
        chipNodes.enumerated().forEach { index, node in
            let data = chipsData[index]
            node.update(data: data)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


struct ChipModel: Equatable {
    let optionId: Int
    let title: String
    var isSelected: Bool
    var isCampaign: Bool
}

final class ChipNode: ASDisplayNode {
    private let titleNode: ASTextNode2 = {
        let titleNode = ASTextNode2()
        titleNode.style.flexShrink = 1
        titleNode.maximumNumberOfLines = 1
        titleNode.truncationMode = .byTruncatingTail
        return titleNode
    }()

    private var notificationNode: ASTextNode2?
    private var data: ChipModel
    
    var didTap: (() -> ())?

    init(data: ChipModel) {
        self.data = data
        super.init()
        automaticallyManagesSubnodes = true
        style.height = ASDimensionMake(40)
        style.minWidth = ASDimensionMake(34) // #2. Set this to lower than 34, and the bug occured (34 = 12 left padding + 10 width of text + 12 right padding)
        style.maxWidth = ASDimensionMake(180)
        // you need to setup in init to avoid the bug
//        update(data: self.data, shouldSetNeedsLayout: false) // #3. Move the update from `didLoad` to init to fix this issue.
    }

    override func layoutSpecThatFits(_: ASSizeRange) -> ASLayoutSpec {
        let stack = ASStackLayoutSpec(
            direction: .horizontal,
            spacing: 6,
            justifyContent: .start,
            alignItems: .center,
            children: [titleNode, notificationNode].compactMap { $0 }
        )
        return ASInsetLayoutSpec(
            insets: UIEdgeInsets(top: 10, left: 12, bottom: 10, right: 12),
            child: stack
        )
    }

    override func didLoad() {
        super.didLoad()
        view.layer.cornerRadius = 16
        setupTapGesture()
        update(data: self.data, shouldSetNeedsLayout: true)
    }

    func update(data: ChipModel, shouldSetNeedsLayout: Bool = true) {
        self.data = data
        titleNode.attributedText = NSAttributedString.title(data.title)
        if data.isSelected {
            backgroundColor = .green
            view.layer.borderWidth = 1
            view.layer.borderColor = UIColor.green.cgColor
        } else {
            backgroundColor = .white
            view.layer.borderWidth = 1
            view.layer.borderColor = UIColor.lightGray.cgColor
        }

        if data.isCampaign {
            notificationNode = ASTextNode2()
            notificationNode?.attributedText = NSAttributedString.title("PROMO")
        } else {
            notificationNode = nil
        }
        
        /// klo di init `textNode.attributedText` awal nil, terus layoutSpec, didLoad baru set Text, harus ada setNeedsLayout, klo ga, ga muncul textnya.
        if shouldSetNeedsLayout {
            setNeedsLayout()
        }
//        supernode?.setNeedsLayout() // #1. Uncomment this line will fix the problem
    }

    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapChip))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func didTapChip() {
        didTap?()
    }
}
