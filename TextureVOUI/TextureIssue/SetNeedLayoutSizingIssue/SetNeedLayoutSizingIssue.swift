//
//  SetNeedLayoutSizingIssue.swift
//  TextureVOUI
//
//  Created by darindra.khadifa on 09/05/22.
//

import AsyncDisplayKit

public final class SetNeedLayoutSizingIssueVC: ASDKViewController<ASScrollNode> {
    private let contentNode = DummyForeachStoreNode(nodes: [PriceInfoCellNode()])
    private let textNode = ASTextNode2()

    override public init() {
        super.init(node: ASScrollNode())
        node.automaticallyManagesContentSize = true
        node.automaticallyManagesSubnodes = true
        node.backgroundColor = UIColor.white

        node.layoutSpecBlock = { [weak self] _, _ in
            guard let self = self else { return ASLayoutSpec() }
            let stack = ASStackLayoutSpec.vertical()
            stack.children = [self.textNode, self.contentNode]
            return ASInsetLayoutSpec(insets: .zero, child: stack)
        }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        textNode.attributedText = .body("Title")
    }

    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

internal final class DummyForeachStoreNode: ASDisplayNode {
    private let nodes: [ASDisplayNode]
    
    init(nodes: [ASDisplayNode]) {
        self.nodes = nodes
        super.init()
        self.automaticallyManagesSubnodes = true
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let stack = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 0,
            justifyContent: .start,
            alignItems: .stretch,
            children: nodes
        )

        let insets = ASInsetLayoutSpec(
            insets: .zero,
            child: stack
        )

        return insets
    }
}

public final class PriceInfoCellNode: ASDisplayNode {
    internal let titleNode = ASTextNode2()
    private let imageNode: ASImageNode = {
        let node = ASImageNode()
//        node.image = UIImage(named: "icon_bebas_ongkir")
        node.style.preferredSize = CGSize(width: 16, height: 16)
        return node
    }()

    override public init() {
        super.init()
        automaticallyManagesSubnodes = true
    }
    
    public override func didLoad() {
        super.didLoad()
//        buttonNode.backgroundColor = .green
        imageNode.addTarget(self, action: #selector(didTap), forControlEvents: .touchUpInside)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.titleNode.attributedText = .body("hrsnya ga muncul")
        }
        
        imageNode.image = UIImage(named: "icon_bebas_ongkir")
    }
    
    @objc private func didTap() {
        titleNode.attributedText = NSAttributedString.body("hrsnya ini muncul")
        setNeedsLayout()
    }

    override public func layoutSpecThatFits(_: ASSizeRange) -> ASLayoutSpec {
        let stack = ASStackLayoutSpec.vertical()
        stack.spacing = 8
//        stack.justifyContent = .spaceBetween
        stack.children = [titleNode, imageNode]

        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10, left: 16, bottom: 0, right: 16), child: stack)
    }
}
