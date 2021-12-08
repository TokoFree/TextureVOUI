//
//  TextureAccessibilityIdentifier.swift
//  TextureVOUI
//
//  Created by andhika.setiadi on 03/12/21.
//

import AsyncDisplayKit

internal final class TextureAccessibilityIdentifier: ASDKViewController<ASScrollNode> {
    private let scrollNode: ASScrollNode = {
        let node = ASScrollNode()
        node.automaticallyManagesContentSize = true
        node.automaticallyManagesSubnodes = true
        node.scrollableDirections = [.up, .down]
        return node
    }()
    
    private let titleTextNode: ASTextNode2 = {
        let node = ASTextNode2()
        node.backgroundColor = .yellow
        node.attributedText = .body("ini title text node text", color: .white)
        node.accessibilityIdentifier = "titleText"
        return node
    }()
    
    private let buttonNode: ASButtonNode = {
        let node = ASButtonNode()
        node.setTitle("Kamu bisa lebih hemat Ro6000", with: nil, with: .white, for: .normal)
        node.accessibilityIdentifier = "usePromoButton"
        // grouping
        node.isAccessibilityElement = false
        return node
    }()
    
    private let titleTextNode2: ASTextNode2 = {
        let node = ASTextNode2()
        node.backgroundColor = .red
        node.attributedText = .body("text baru", color: .white)
        node.accessibilityIdentifier = "NewTextLabel"
        return node
    }()
    
    private let rowNode: ASControlNode = {
        let node1 = ASTextNode2()
        node1.attributedText = .body("Pengiriman", color: .white)
        node1.accessibilityIdentifier = "pengirimanLabel"

        let node2 = ASTextNode2()
        node2.attributedText = .body("Rp15.000", color: .white)
        node2.accessibilityIdentifier = "priceLabel"
        
        // empty ASDIsplayNode will not show any identifier
        let node3 = ASDisplayNode()
        node3.backgroundColor = .blue
        node3.style.preferredSize = CGSize(width: 100, height: 100)
        node3.accessibilityIdentifier = "node3Dummy"
        
        let node = ASControlNode()
        node.automaticallyManagesSubnodes = true
        node.accessibilityIdentifier = "rowNodeIdentifier"
        node.layoutSpecBlock = { _, _ in
            let stack = ASStackLayoutSpec.vertical()
            stack.spacing = 8
            stack.children = [
                node1,
                node2,
                node3
            ]

            return stack
        }
        return node
    }()

    private let rowNode2: ASDisplayNode = {
        let node1 = ASTextNode2()
        node1.attributedText = .body("Pengiriman", color: .white)
        node1.accessibilityIdentifier = "pengirimanLabel2"

        let node2 = ASTextNode2()
        node2.attributedText = .body("Rp15.000", color: .white)
        node2.accessibilityIdentifier = "priceLabel2"
        
        // empty ASDIsplayNode will not show any identifier
        let node3 = ASDisplayNode()
        node3.backgroundColor = .blue
        node3.style.preferredSize = CGSize(width: 100, height: 100)
        node3.accessibilityIdentifier = "node3Dummy2"
        
        let node = ASDisplayNode()
        node.automaticallyManagesSubnodes = true
        node.accessibilityIdentifier = "rowNodeIdentifier2"
        node.layoutSpecBlock = { _, _ in
            let stack = ASStackLayoutSpec.vertical()
            stack.spacing = 8
            stack.children = [
                node1,
                node2,
                node3
            ]

            return stack
        }
        return node
    }()
    
    // proofing empty ASDisplayNode not gonna show any identifier
    private let pocDummyNode: ASDisplayNode = {
        let node = ASDisplayNode()
        node.backgroundColor = .yellow
        node.style.preferredSize = CGSize(width: 100, height: 100)
        node.accessibilityIdentifier = "pocDummyNode"
        return node
    }()
    
    private let rowNode3: ASDisplayNode = {
        let node1 = ASTextNode2()
        node1.attributedText = .body("Pengiriman", color: .white)
        node1.accessibilityIdentifier = "pengirimanLabel2"

        let node2 = ASTextNode2()
        node2.attributedText = .body("Rp15.000", color: .white)
        node2.accessibilityIdentifier = "priceLabel2"
        
        let node3 = ASDisplayNode()
        node3.backgroundColor = .green
        node3.style.preferredSize = CGSize(width: 100, height: 100)
        node3.accessibilityIdentifier = "node3Dummy2"
        
        let nodeWrapper = ASDisplayNode()
        nodeWrapper.backgroundColor = .blue
        nodeWrapper.style.preferredSize = CGSize(width: 200, height: 200)
        nodeWrapper.accessibilityIdentifier = "nodeWrapper"
        nodeWrapper.isAccessibilityElement = false
        nodeWrapper.layoutSpecBlock = { _,_ in
            return ASWrapperLayoutSpec(layoutElement: node3)
        }
        
        let node = ASDisplayNode()
        node.automaticallyManagesSubnodes = true
        node.accessibilityIdentifier = "rowNodeIdentifier2"
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
    
    private let rowNode4: ASDisplayNode = {
        let node1 = ASTextNode2()
        node1.attributedText = .body("Pengiriman", color: .white)
        node1.accessibilityIdentifier = "pengirimanLabel2"

        let node2 = ASTextNode2()
        node2.attributedText = .body("Rp15.000", color: .white)
        node2.accessibilityIdentifier = "priceLabel2"
        
        let node3 = ASTextNode2()
        node3.attributedText = .body("Rp15.000", color: .white)
        node3.accessibilityIdentifier = "priceLabel3"
        node3.isAccessibilityElement = true
        
        let nodeWrapper = ASDisplayNode()
        nodeWrapper.backgroundColor = .blue
        nodeWrapper.style.preferredSize = CGSize(width: 200, height: 200)
        nodeWrapper.accessibilityIdentifier = "nodeWrapper"
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
                self.titleTextNode,
                self.buttonNode,
                self.titleTextNode2,
                self.rowNode,
                self.pocDummyNode,
                self.rowNode2,
                self.rowNode3,
                self.rowNode4
            ]
            
            return stack
        }
    }
    
    internal required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
