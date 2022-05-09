//
//  SetNeedLayoutSizingIssue.swift
//  TextureVOUI
//
//  Created by darindra.khadifa on 09/05/22.
//

import AsyncDisplayKit

public final class SetNeedLayoutSizingIssueVC: ASDKViewController<ASDisplayNode> {
    private let contentNode = SetNeedLayoutSizingIssueContentNode()

    override public init() {
        super.init(node: ASDisplayNode())
        node.automaticallyManagesSubnodes = true
        node.backgroundColor = UIColor.white

        node.layoutSpecBlock = { [weak self] _, _ in
            guard let self = self else { return ASLayoutSpec() }
            return ASWrapperLayoutSpec(layoutElement: self.contentNode)
        }
    }

    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public final class SetNeedLayoutSizingIssueContentNode: ASDisplayNode {
    private let titleNode = ASTextNode2()

    private let buttonNode: ASButtonNode = {
        let node = ASButtonNode()
        node.setAttributedTitle(NSAttributedString(string: "Tap"), for: .normal)
        node.style.height = ASDimensionMake(40)
        return node
    }()

    override public init() {
        super.init()
        automaticallyManagesSubnodes = true
    }

    override public func didLoad() {
        super.didLoad()
        
        titleNode.attributedText = NSAttributedString.body("Testing")
        
        buttonNode.backgroundColor = .lightGray
        buttonNode.addTarget(self, action: #selector(didTap), forControlEvents: .touchUpInside)
    }

    override public func layoutSpecThatFits(_: ASSizeRange) -> ASLayoutSpec {
        let stack = ASStackLayoutSpec.vertical()
        stack.spacing = 16
        stack.children = [titleNode, buttonNode]

        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10, left: 16, bottom: 0, right: 16), child: stack)
    }

    @objc private func didTap() {
        print("<<< TESTING")
    }
}
