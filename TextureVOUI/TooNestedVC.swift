//
//  TooNestedVC.swift
//  TextureVOUI
//
//  Created by Jefferson Setiawan on 13/09/21.
//

import AsyncDisplayKit

/// Minimal STR to reproduct Texture 2 UI Test issue that can't get the deepest element
class TooNestedVC: ASDKViewController<ASDisplayNode> {
    private let explanationNode: ASTextNode2 = {
        let node = ASTextNode2()
        node.attributedText = NSAttributedString(string: "Demo for too nested hierarchy")
        node.accessibilityIdentifier = "explanationTextNode"
        return node
    }()
    private let scrollNode: ASScrollNode = {
        let node = ASScrollNode()
        node.automaticallyManagesContentSize = true
        node.automaticallyManagesSubnodes = true
        node.scrollableDirections = [.up, .down]
        return node
    }()
    
    private let rowNode3: ASDisplayNode = {
        let node1 = ASTextNode2()
        node1.attributedText = .body("Pengiriman", color: .white)
        node1.accessibilityIdentifier = "pengirimanLabel3"

        let node2 = ASTextNode2()
        node2.attributedText = .body("Rp15.000", color: .white)
        node2.accessibilityIdentifier = "priceLabel3"
        
        let node3 = ASTextNode2()
        node3.backgroundColor = .green
        node3.style.preferredSize = CGSize(width: 100, height: 100)
        node3.attributedText = .body("Node ke 3", color: .white)
        node3.accessibilityIdentifier = "node3Text"
        
        let nodeWrapper = ASControlNode()
        nodeWrapper.backgroundColor = .blue
        nodeWrapper.style.preferredSize = CGSize(width: 200, height: 200)
        nodeWrapper.accessibilityIdentifier = "nodeWrapper3"
        nodeWrapper.automaticallyManagesSubnodes = true
//        nodeWrapper.isAccessibilityElement = true // Uncomment this, the `node3Text` will not visible
        nodeWrapper.layoutSpecBlock = { _,_ in
            return ASWrapperLayoutSpec(layoutElement: node3)
        }
        
        let node = ASDisplayNode()
        node.automaticallyManagesSubnodes = true
        node.accessibilityIdentifier = "rowNodeIdentifier3"
        node.layoutSpecBlock = { _, _ in
            let stack = ASStackLayoutSpec.vertical()
            stack.spacing = 8
            stack.children = [
                node1,
                node2,
                nodeWrapper
            ]

            return stack
        }
        return node
    }()
    
    internal override init() {
        super.init(node: scrollNode)
        
        title = "Example Identifier in Texture"
        
        node.backgroundColor = .black
        
        node.layoutSpecBlock = { [weak self] _,_ in
            guard let self = self else { return ASLayoutSpec() }
            
            let stack = ASStackLayoutSpec.vertical()
            stack.spacing = 8
            stack.children = [
                self.explanationNode,
                self.rowNode3
            ]
            
            return stack
        }
    }
    
    internal required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

