//
//  ParentWithWrapperDoesNotAutoSetNeedsLayoutVC.swift
//  TextureVOUI
//
//  Created by Adriani Zenitha on 04/11/21.
//

import AsyncDisplayKit
import Foundation

/*
    Issue: If parent node is using `ASWrapperLayoutSpec`, it won't be automatically setNeedsLayout after setNeedsLayout its children, most likely because `ASWrapperLayoutSpec` size fills its parent, so it doesn't need to recalculate its size.
    Solution: Use `ASStackLayoutSpec`, or manually setNeedsLayout the parent.
 */

public final class ParentWithWrapperDoesNotAutoSetNeedsLayoutVC: ASDKViewController<ASDisplayNode> {
    private let contentNode = ContentNode()

    public override init() {
        super.init(node: ASDisplayNode())

        node.automaticallyManagesSubnodes = true
        node.backgroundColor = UIColor.white
        node.layoutSpecBlock = { [weak self] _, _ in
            guard let self = self else { return ASLayoutSpec() }

            print(">>>> layoutSpecBlock root node")
            return ASWrapperLayoutSpec(layoutElement: self.contentNode)

            // Uncomment to use ASStackLayout instead of ASWrapper and this `layoutSpecBlock` will automatically be called after setNeedsLayout `contentNode`
//            return ASStackLayoutSpec(direction: .vertical, spacing: 0, justifyContent: .start, alignItems: .stretch, children: [self.contentNode])
        }
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public final class ContentNode: ASDisplayNode {
    private var greenNode: ASDisplayNode? = {
        let node = ASDisplayNode()
        node.backgroundColor = UIColor.green
        node.style.height = ASDimensionMake(100)
        return node
    }()

    private let redNode: ASControlNode = {
        let node = ASControlNode()
        node.backgroundColor = UIColor.red
        node.style.height = ASDimensionMake(100)
        return node
    }()

    public override init() {
        super.init()
        automaticallyManagesSubnodes = true
    }

    public override func didLoad() {
        super.didLoad()
        redNode.addTarget(self, action: #selector(didTapRedNode), forControlEvents: .touchUpInside)
    }

    public override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        print(">>>> layoutSpecThatFits ContentNode")

        var children: [ASLayoutElement] = [redNode]
        if let greenNode = greenNode {
            children.append(greenNode)
        }

        return ASStackLayoutSpec(direction: .vertical, spacing: 16, justifyContent: .start, alignItems: .stretch, children: children)
    }

    @objc private func didTapRedNode() {
        print(">>>> didTapRedNode")
        greenNode = nil
        setNeedsLayout()
    }
}
