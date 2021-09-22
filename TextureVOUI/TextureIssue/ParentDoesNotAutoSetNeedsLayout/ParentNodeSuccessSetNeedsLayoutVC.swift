//
//  ParentNodeSuccessSetNeedsLayoutVC.swift
//  TextureVOUI
//
//  Created by Jefferson Setiawan on 17/09/21.
//

import AsyncDisplayKit

class ParentNodeSuccessSetNeedsLayoutVC: ASDKViewController<ASDisplayNode> {
    private let titleNode: ASTextNode2 = {
        let textNode = ASTextNode2()
        textNode.attributedText = .init(string: "You can try switching the chip from 2 to 6 to reproduce the bug. When 2 is selected, the 2 has promo, when 6 is selected, the 2 will not have promo.")
        
        return textNode
    }()
    private var chipNodes: [UnifyChipNode] = []
    
    private var chipsData: [ChipModel] = [
        ChipModel(optionId: 1, title: "200", isSelected: true, isCampaign: true),
        ChipModel(optionId: 2, title: "400", isSelected: false, isCampaign: false),
        ChipModel(optionId: 3, title: "600", isSelected: false, isCampaign: true),
    ]
    
    override init() {
        let rootNode = ASDisplayNode()
        super.init(node: rootNode)
        chipDidTap(2)
        chipNodes = chipsData.enumerated().map { [unowned self] index, data in
            let node = UnifyChipNode(title: data.title)
            if data.isCampaign {
                node.notification = "PROMO"
            } else {
                node.notification = nil
            }
            node.state = data.isSelected ? .selected : .normal
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
            if data.isCampaign {
                node.notification = "PROMO"
            } else {
                node.notification = nil
            }
            node.state = data.isSelected ? .selected : .normal
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



public class UnifyChipNode: ASDisplayNode {
    public enum State: Int {
        case normal
        case selected
        case disabled

        internal var backgroundColor: UIColor {
            switch self {
            case .normal:
                return .white
            case .selected:
                return .green
            case .disabled:
                return .gray
            }
        }
    }

    /// modify title in this chip
    /// if title is too long, that title will be truncated
    public var title: String {
        didSet {
            configureTitle()
        }
    }

    /// set state to this chip
    /// you can set the state by enum `ChipNode.State`
    /// if you set `state` to disable, you won't can tap this node
    /// default `state` is `normal`
    public var state: State = .normal {
        didSet {
            backgroundColor = state.backgroundColor
//            configureTitle()
        }
    }

    /// set notification for this chip
    /// will be placed next to `title`
    /// default `notification` is `nil`
    public var notification: String? {
        didSet {
            configureNotification()
            // safety for case when one of the subnodes is performing one
            // Ex: call set State & set Notification
            setNeedsLayout()
        }
    }

    /// style for this chip
    /// default `style` is `normal`
    public var didTap: (() -> Void)?

    private let titleNode: ASTextNode2 = {
        let titleNode = ASTextNode2()
        titleNode.style.flexShrink = 1
        titleNode.maximumNumberOfLines = 1
        titleNode.displaysAsynchronously = false
        titleNode.truncationMode = .byTruncatingTail
        return titleNode
    }()

    private var notificationNode: ASTextNode2?

    public init(title: String,
                notification: String? = nil) {
        self.title = title
        self.notification = notification

        super.init()
        automaticallyManagesSubnodes = true

        commonInit()
    }

    private func commonInit() {
        configureChipSize()
        configureTitle()
        configureNotification()
    }

    override public func didLoad() {
        super.didLoad()
        
        // #1. This cause bug when change the title in didLoad & do the setNeedsLayouut, it's fine if you don't setNeedsLayout
//        self.title = "AAA \(self.title)"
//        self.setNeedsLayout()
        
        backgroundColor = state.backgroundColor
        layer.borderWidth = 1
        layer.cornerRadius = 16

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapChipNode))
        view.addGestureRecognizer(tapGesture)
    }

    override public func layoutSpecThatFits(_: ASSizeRange) -> ASLayoutSpec {
        print("<<< LayoutSpec \(title)")
        let contentStack = ASStackLayoutSpec(direction: .horizontal,
                                             spacing: 4,
                                             justifyContent: .start,
                                             alignItems: .center,
                                             children: [titleNode, notificationNode].compactMap { $0 })

        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12), child: contentStack)
    }

    private func configureTitle() {
        titleNode.attributedText = .title(title)
    }

    private func configureChipSize() {
        style.height = ASDimensionMake(40)
        style.minWidth = ASDimensionMake(40)
    }

    private func configureNotification() {
        if let notification = notification {
            notificationNode = ASTextNode2()
            notificationNode?.attributedText = .title(notification)
        } else {
            notificationNode = nil
        }
    }

    @objc private func didTapChipNode() {
        didTap?()
    }
}

