//
//  NodeCreationInsideLayoutVC.swift
//  TextureVOUI
//
//  Created by andhika.setiadi on 28/10/22.
//

import AsyncDisplayKit

internal final class NodeCreationInsideLayoutVC: ASDKViewController<ASScrollNode> {
    
    // MARK: Nodes
    
    private let rootNode: ASScrollNode = {
        let node = ASScrollNode()
        node.automaticallyManagesSubnodes = true
        node.automaticallyManagesContentSize = true
        node.scrollableDirections = [.up, .down]
        node.backgroundColor = .white
        return node
    }()
    
    private let infoTextNode: ASTextNode = {
        let node = ASTextNode()
        node.attributedText = .body("If you see any others colored text, means you in Debug mode build, tried to change into release mode build from Edit Scheme > Run > Build Configuration -> Release")
        return node
    }()
    
    private let info2TextNode: ASTextNode = {
        let node = ASTextNode()
        node.attributedText = .body("Happened on Xcode 14")
        return node
    }()
    
    // MARK: Variables
    
    // MARK: Lifecycles
    
    internal override init() {
        super.init(node: rootNode)
        
        rootNode.layoutSpecBlock = { [weak self] _, _ in
            guard let self = self else { return ASLayoutSpec() }
            
            /// here we demonstrate the node creation on layouting scope
            let newTextNode = ASTextNode()
            newTextNode.attributedText = .body("HEHEHE Test ya")
            newTextNode.backgroundColor = .yellow
            
            let newTextNode2 = ASTextNode()
            newTextNode2.attributedText = .body("HEHEHE Test ya")
            newTextNode2.backgroundColor = .blue
            
            /// also this one approach is also we can say
            /// this one is create the node in layouting scope
            let newTextNode3 = self.createNode()
            
            let stack = ASStackLayoutSpec.vertical()
            stack.spacing = 8
            stack.children = [
                self.infoTextNode,
                self.info2TextNode,
                newTextNode,
                newTextNode2,
                newTextNode3
            ]
            
            let insetStack = ASInsetLayoutSpec(
                insets: UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16),
                child: stack
            )
            
            return ASWrapperLayoutSpec(layoutElement: insetStack)
        }
    }
    
    private func createNode() -> ASTextNode {
        let newTextNode3 = ASTextNode()
        newTextNode3.attributedText = .body("HEHEHE Test ya")
        newTextNode3.backgroundColor = .green
        return newTextNode3
    }
    
    internal required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    #if DEBUG
        deinit {
            print(">>> deinit \(String(describing: self))")
        }
    #endif
}
