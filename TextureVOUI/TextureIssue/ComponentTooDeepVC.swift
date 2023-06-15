//
//  ComponentTooDeepVC.swift
//  TextureVOUI
//
//  Created by jefferson.setiawan on 15/06/23.
//

import AsyncDisplayKit

/*
 Example case when the component that too deep can not detected by UITest / Voice Over
 */
internal final class ComponentTooDeepVC: ASDKViewController<ASDisplayNode> {
    private let aNode: ASDisplayNode
    override init() {
        /// Code to recursivly add the dummyNode to `DummyNodeThatHasAnotherNode` that is 10 hierarchy deep
        let maxDeep = 55
        aNode = (0...maxDeep).reversed().reduce(DummyNode(), { partialResult, index -> ASDisplayNode in
            DummyNodeThatHasAnotherNode(childNode: partialResult, index: index)
        })
        super.init(node: ASDisplayNode())
        node.automaticallyManagesSubnodes = true
        node.layoutSpecBlock = { [unowned self] _, _ in
            ASWrapperLayoutSpec(layoutElement: aNode)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

internal final class DummyNodeThatHasAnotherNode: ASDisplayNode {
    private let randomColors = [UIColor.red, .blue, .yellow, .black, .cyan, .magenta]
    private let childNode: ASDisplayNode
    internal init(childNode: ASDisplayNode, index: Int) {
        self.childNode = childNode
        super.init()
        self.accessibilityIdentifier = "component-\(index)"
        self.backgroundColor = randomColors.randomElement()!
        automaticallyManagesSubnodes = true
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        ASInsetLayoutSpec(insets: UIEdgeInsets(top: 2, left: 0, bottom: 2, right: 0), child: self.childNode)
    }
}

internal final class DummyNode: ASDisplayNode {
    private let textNode: ASTextNode2 = {
        let node = ASTextNode2()
        node.attributedText = .title("Title text")
        node.accessibilityIdentifier = "textIdentifier"
        return node
    }()
    
    override init() {
        super.init()
        backgroundColor = .yellow
        automaticallyManagesSubnodes = true
    }
    
    internal override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        ASInsetLayoutSpec(insets: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16), child: textNode)
    }
}
