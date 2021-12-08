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
    
//    private let rowNode: ASControlNode = {
//        let node1 = ASTextNode2()
//        node1.attributedText = .body("Pengiriman", color: .white)
//        node1.accessibilityIdentifier = "pengirimanLabel"
//
//        let node = ASTextNode2()
//        node2.attributedText = .body("Rp15.000", color: .white)
//        node2.accessibilityIdentifier = "priceLabel"
//
//        let node = ASControlNode()
//        node.automaticallyManagesSubnodes = true
//        node.layoutSpecBlock = { _, _ in
//            let stack = ASStackLayoutSpec.vertical()
//            stack.spacing = 8
//            stack.children = [
//                self.titleTextNode,
//                self.buttonNode
//            ]
//
//            return stack
//        }
//        return node
//    }()
    
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
                self.titleTextNode2
            ]
            
            return stack
        }
    }
    
    internal required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
