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
    var chipNodes: [UnifyChipNode] = []
    
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

        internal var borderColor: CGColor {
            switch self {
            case .normal:
                return UIColor.white.cgColor
            case .selected:
                return UIColor.green.cgColor
            case .disabled:
                return UIColor.gray.cgColor
            }
        }

        internal var titleColor: UIColor {
            switch self {
            case .normal:
                return .black
            case .selected:
                return .green
            case .disabled:
                return .lightGray
            }
        }
    }

    /**
     Styles that available on `ChipNode`. .
     `normal` style will use gray color for border color and text color
     `alternate` style will use green color for border color and text color
     This style only applied when ChipNode `state` is `normal`
     */
    public enum ChipStyle {
        case normal, alternate
    }

    /**
     Action Item (clickable) that available for placed on the right of `ChipNode`.
     You can get callback whenever `accessoryAction` tapped by access `didTapAccessory()` or `rx.tapAccessory`
     */
    public enum AccessoryAction {
        case closeable, dropdown
    }

    /// modify title in this chip
    /// if title is too long, that title will be truncated
    public var title: String {
        didSet {
            configureTitle()
            updateAccessibility()
        }
    }

    /// set state to this chip
    /// you can set the state by enum `ChipNode.State`
    /// if you set `state` to disable, you won't can tap this node
    /// default `state` is `normal`
    public var state: State = .normal {
        didSet {
            configureChipAppearance(animated: true)
            configureTitle()
            updateAccessibility()
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
            updateAccessibility()
        }
    }

    /// style for this chip
    /// default `style` is `normal`
    public var didTap: (() -> Void)?

    private lazy var titleNode: ASTextNode2 = {
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
        accessibilityLabel = title
        automaticallyManagesSubnodes = true
        isAccessibilityElement = true
        updateAccessibility()

        commonInit()
    }

    private func commonInit() {
        configureChipSize()
        configureTitle()
        configureNotification()
    }

    override public func didLoad() {
        super.didLoad()
        configureChipAppearance(animated: false)

        layer.borderWidth = 1
        layer.cornerRadius = 16

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapChipNode))
        view.addGestureRecognizer(tapGesture)
    }

    override public func layoutSpecThatFits(_: ASSizeRange) -> ASLayoutSpec {
        var children: [ASLayoutElement] = [titleNode]

        // Configure Accessory Layout
        if let notificationNode = notificationNode {
            children.append(notificationNode)
        }
        let contentStack = ASStackLayoutSpec(direction: .horizontal,
                                             spacing: 4,
                                             justifyContent: .start,
                                             alignItems: .center,
                                             children: children)

        let contentStackRightInset: CGFloat = 12
        let contentStackInset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 8, left: 12, bottom: 8, right: contentStackRightInset), child: contentStack)

        return contentStackInset
    }

    private func configureChipAppearance(animated: Bool) {
        backgroundColor = state.backgroundColor
    }

    private func configureTitle() {
        titleNode.attributedText = .title(title)
    }

    private func configureChipSize() {
        // height and width are same values
        style.height = ASDimensionMake(40)
        style.minWidth = ASDimensionMake(40)

        // here we apply rules for ellipsis
        // if true we set maxWidth
        // if not we let the chip follow its width text
        style.maxWidth = ASDimensionMake(180)
    }

    private func configureNotification() {
        if let notification = notification, !notification.isEmpty {
            notificationNode = ASTextNode2()
            notificationNode?.attributedText = .title(notification)
        } else {
            notificationNode = nil
        }
    }

    private func updateAccessibility() {
        switch state {
        case .disabled:
            accessibilityTraits = [.notEnabled, .button]
        case .normal:
            accessibilityTraits = [.button]
        case .selected:
            accessibilityTraits = [.button, .selected]
        }
        if let notification = notification, !notification.isEmpty {
            accessibilityLabel = "\(title), \(notification)"
        } else {
            accessibilityLabel = title
        }
    }

    @objc private func didTapChipNode() {
        didTap?()
    }
}

