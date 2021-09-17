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
        textNode.attributedText = .init(string: "You can try switching the chip from 2 to 6 to reproduce the bug. When 2 is selected, the 2 has promo, when 6 is selected, the 2 will not have promo.")
        
        return textNode
    }()
    var chipNodes: [ChipNode] = []
    
    var chipsData: [ChipModel] = [
        ChipModel(optionId: 1, title: "2", isSelected: true, isCampaign: true, isStockAvailable: true),
        ChipModel(optionId: 2, title: "4", isSelected: false, isCampaign: false, isStockAvailable: true),
        ChipModel(optionId: 3, title: "6", isSelected: false, isCampaign: true, isStockAvailable: true),
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
            return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 90, left: 8, bottom: 0, right: 8), child: vStack)
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
    var isStockAvailable: Bool
}

final class ChipNode: ASDisplayNode {
    private let chipText: ASTextNode2 = {
        let node = ASTextNode2()
        node.style.flexShrink = 1
        node.maximumNumberOfLines = 1
        node.truncationMode = .byTruncatingTail
        return node
    }()

    private var promoBadge: ASTextNode2?
    private var data: ChipModel
    
    var didTap: (() -> ())?

    init(data: ChipModel) {
        self.data = data
        super.init()
        automaticallyManagesSubnodes = true
        isAccessibilityElement = true
        style.height = ASDimensionMake(40)
        style.maxWidth = ASDimensionMake(180)
    }

    override func layoutSpecThatFits(_: ASSizeRange) -> ASLayoutSpec {
        let stack = ASStackLayoutSpec(
            direction: .horizontal,
            spacing: 6,
            justifyContent: .start,
            alignItems: .center,
            children: [chipText, promoBadge].compactMap { $0 }
        )
        return ASInsetLayoutSpec(
            insets: UIEdgeInsets(top: 10, left: 12, bottom: 10, right: 12),
            child: stack
        )
    }

    override func didLoad() {
        super.didLoad()
        view.layer.cornerRadius = 16
        update(data: self.data)
        setupTapGesture()
    }

    func update(data: ChipModel) {
        self.data = data
        chipText.attributedText = NSAttributedString.title(data.title)
        if data.isStockAvailable {
            if data.isSelected {
                setupChipSelected()
            } else {
                setupChipUnselected()
                setupStockAvailable()
            }
        } else {
            if data.isSelected {
                setupChipSelected()
            } else {
                setupChipUnselected()
                setupOutOfStock()
            }
        }
        setNeedsLayout()
        

        if data.isCampaign {
            setupPromo()
        } else {
            promoBadge = nil
        }
        setNeedsLayout()
//        need to call parent to rerender the chip size
//        supernode?.setNeedsLayout()
    }

    private func setupPromo() {
        promoBadge = ASTextNode2()
        promoBadge?.attributedText = NSAttributedString.title("PROMO")
    }

    private func setupChipSelected() {
        backgroundColor = .green
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.green.cgColor
        chipText.attributedText = NSAttributedString.title(data.title)
    }

    private func setupChipUnselected() {
        backgroundColor = .white
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        chipText.attributedText = NSAttributedString.title(data.title)
    }

    private func setupStockAvailable() {
        backgroundColor = .white
        chipText.attributedText = NSAttributedString.title(data.title)
    }

    private func setupOutOfStock() {
        backgroundColor = .white
        chipText.attributedText = NSAttributedString.title(data.title)
    }

    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapChip))
        view.addGestureRecognizer(tapGesture)
        view.isUserInteractionEnabled = true
    }
    
    @objc private func didTapChip() {
        didTap?()
    }
}

final class SimpleChipNode: ASDisplayNode {
    private let chipText: ASTextNode2 = {
        let node = ASTextNode2()
        node.maximumNumberOfLines = 1
        node.truncationMode = .byTruncatingTail
        return node
    }()

    private var promoBadge: ASTextNode2?
    private var data: ChipModel
    
    var didTap: (() -> ())?

    init(data: ChipModel) {
        self.data = data
        super.init()
        automaticallyManagesSubnodes = true
        isAccessibilityElement = true
        style.height = ASDimensionMake(40)
    }

    override func layoutSpecThatFits(_: ASSizeRange) -> ASLayoutSpec {
        let stack = ASStackLayoutSpec(
            direction: .horizontal,
            spacing: 6,
            justifyContent: .start,
            alignItems: .center,
            children: [chipText, promoBadge].compactMap { $0 }
        )
        return ASInsetLayoutSpec(
            insets: UIEdgeInsets(top: 10, left: 12, bottom: 10, right: 12),
            child: stack
        )
    }

    override func didLoad() {
        super.didLoad()
        update(data: self.data)
        setupTapGesture()
    }

    func update(data: ChipModel) {
        self.data = data
        chipText.attributedText = NSAttributedString.title(data.title)
        if data.isStockAvailable {
            if data.isSelected {
                setupChipSelected()
            } else {
                setupChipUnselected()
                setupStockAvailable()
            }
        } else {
            if data.isSelected {
                setupChipSelected()
            } else {
                setupChipUnselected()
                setupOutOfStock()
            }
        }

        if data.isCampaign {
            setupPromo()
        } else {
            promoBadge = nil
        }
        setNeedsLayout()
//        need to call parent to rerender the chip size
//        supernode?.setNeedsLayout()
    }

    private func setupPromo() {
        promoBadge = ASTextNode2()
        promoBadge?.attributedText = NSAttributedString.title("PROMO")
    }

    private func setupChipSelected() {
        backgroundColor = .green
    }

    private func setupChipUnselected() {
        backgroundColor = .white
    }

    private func setupStockAvailable() {
        backgroundColor = .white
    }

    private func setupOutOfStock() {
        backgroundColor = .white
    }

    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapChip))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func didTapChip() {
        didTap?()
    }
}
