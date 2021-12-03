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
        node.attributedText = .body("ini title text node text", color: .white)
        node.accessibilityIdentifier = "titleText"
        node.accessibilityLabel = "test"
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
                self.titleTextNode
            ]
            
            return stack
        }
    }
    
    internal required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
