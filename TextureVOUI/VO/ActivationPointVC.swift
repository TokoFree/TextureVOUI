//
//  ActivationPointVC.swift
//  TextureVOUI
//
//  Created by Jefferson Setiawan on 16/09/21.
//

import AsyncDisplayKit

public final class ActivationPointVC: ASDKViewController<ASDisplayNode> {
    private let explanationNode: ASTextNode = {
        let node = ASTextNode()
        node.attributedText = NSAttributedString.title("""
        After grouping element together, sometimes you want to change the activationpoint of voice over.
        Let say in this case, we group together a ASTextNode and a ASButtonNode.
        By union this to 1 element, when you double tap to activate in voice over, by default voice over will tap in the center of the frame, which will not come to the ASButtonNode. If you want that element to change the tap point, you can change the `accessibilityActivationPoint`

        This only works in Texture 3
        """)
        return node
    }()
    
    private let leftLabelNode: ASTextNode = {
        let node = ASTextNode()
        node.attributedText = NSAttributedString.title("Left text")
        return node
    }()

    private let rightButtonNode: ASButtonNode = {
        let node = ASButtonNode()
        node.setAttributedTitle(NSAttributedString(string: "Tap me"), for: .normal)
        return node
    }()
    
    private let customNode = CustomForActivationNode()

    private let otherTextNode: ASTextNode = {
        let node = ASTextNode()
        node.attributedText = NSAttributedString.title("""
        Other Footer node
        """)
        return node
    }()

    private lazy var leftRightElement: UIAccessibilityElement = {
        let element = UIAccessibilityElement(accessibilityContainer: self.node!)
        element.accessibilityLabel = "Left Text"
        element.accessibilityTraits = .button
        return element
    }()
    
    override public init() {
        super.init(node: ASDisplayNode())
        node.automaticallyManagesSubnodes = true
        node.backgroundColor = .white
        node.accessibilityElements = [explanationNode, leftRightElement, customNode, otherTextNode]
        node.layoutSpecBlock = { [unowned self] _, _ in
            let hStack = ASStackLayoutSpec(
                direction: .horizontal,
                spacing: 16,
                justifyContent: .spaceAround,
                alignItems: .stretch,
                children: [
                    leftLabelNode, rightButtonNode
                ]
            )
            let stack = ASStackLayoutSpec(
                direction: .vertical,
                spacing: 32,
                justifyContent: .start,
                alignItems: .stretch,
                children: [
                    explanationNode,
                    hStack,
                    customNode,
                    otherTextNode
                ]
            )
            return ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: .minimumY, child: stack)
        }
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        rightButtonNode.addTarget(self, action: #selector(didTap), forControlEvents: .touchUpInside)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        node.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func tapAction(_ sender: UITapGestureRecognizer) {
        let point = sender.location(in: node.view)
        otherTextNode.attributedText = NSAttributedString(string: "\(point)")
    }

    @objc private func didTap() {
        present(UIAlertController.dummy(), animated: true, completion: nil)
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateAccessibilityFrame()
    }

    override public func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateAccessibilityFrame() // somehow when first open, the frame of node is still 0, so need to listen inside viewWillAppear
    }
    
    private func updateAccessibilityFrame() {
        let combinedFrame = rightButtonNode.frame.union(leftLabelNode.frame)
        leftRightElement.accessibilityActivationPoint = CGPoint(x: 249.25, y: 437)
        leftRightElement.accessibilityFrameInContainerSpace = combinedFrame // Bug when user rotate
        print("<<< frame: ", rightButtonNode.frame)
        print("<<< rightButtonNode.accessibilityFrame: ", rightButtonNode.accessibilityFrame)
        print("<<< activationPoint: ", rightButtonNode.accessibilityActivationPoint)
        print("<<< super: ", rightButtonNode.supernode)
        let convertedFrame = rightButtonNode.convert(rightButtonNode.bounds, to: rightButtonNode.supernode)
        let midConvertedFrame = CGPoint(x: convertedFrame.midX, y: convertedFrame.midY)
        print("<<< node convert: ", midConvertedFrame)
//        leftLabelNode.accessibilityActivationPoint = rightButtonNode
//        leftLabelNode.accessibilityActivationPoint = CGPoint(x: 781, y: 442)
         // rightButtonNode.view.accessibilityActivationPoint // CGPoint(x: frame.midX, y: frame.midY) // rightButtonNode.convert(CGPoint(x: rightButtonNode.frame.midX, y: rightButtonNode.frame.midY), to: node)
    }

    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

internal final class CustomForActivationNode: ASDisplayNode {
    private let leftLabelNode: ASTextNode = {
        let node = ASTextNode()
        node.attributedText = NSAttributedString.title("Left text")
        return node
    }()

    private let rightButtonNode: ASButtonNode = {
        let node = ASButtonNode()
        node.setAttributedTitle(NSAttributedString(string: "Tap me"), for: .normal)
        return node
    }()

    private let otherTextNode: ASTextNode = {
        let node = ASTextNode()
        node.attributedText = NSAttributedString.title("""
        Other Footer node
        """)
        return node
    }()
    
    private lazy var leftRightElement: UIAccessibilityElement = {
        let element = UIAccessibilityElement(accessibilityContainer: self)
        element.accessibilityLabel = "Left Text"
        element.accessibilityTraits = .button
        return element
    }()
    
    override internal var accessibilityElements: [Any]? {
        get {
            [leftRightElement, otherTextNode]
        }
        set {}
    }
    
    override internal init() {
        super.init()
        automaticallyManagesSubnodes = true
        backgroundColor = .white
    }
    
    override func didLoad() {
        super.didLoad()
//        rightButtonNode.addTarget(self, action: #selector(didTap), forControlEvents: .touchUpInside)
    }
    
    @objc private func didTap() {
        closestViewController?.present(UIAlertController.dummy(), animated: true, completion: nil)
    }
    
    override internal func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let hStack = ASStackLayoutSpec(
            direction: .horizontal,
            spacing: 16,
            justifyContent: .spaceAround,
            alignItems: .stretch,
            children: [
                leftLabelNode, rightButtonNode
            ]
        )
        let stack = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 32,
            justifyContent: .start,
            alignItems: .stretch,
            children: [
                hStack,
                otherTextNode
            ]
        )
        return stack
    }
    
    override internal func layout() {
        super.layout()
        let combinedFrame = rightButtonNode.frame.union(leftLabelNode.frame)
        leftRightElement.accessibilityActivationPoint = rightButtonNode.accessibilityActivationPoint
        leftRightElement.accessibilityFrameInContainerSpace = combinedFrame // Bug when user rotate
    }
}

extension UIAlertController {
    internal static func dummy() -> UIAlertController {
        let alertVC = UIAlertController(title: "You tap", message: "You tap the button", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        return alertVC
    }
}

