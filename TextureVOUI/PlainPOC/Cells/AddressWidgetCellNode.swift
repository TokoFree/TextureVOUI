//
//  AddressWidgetCellNode.swift
//  TextureVOUI
//
//  Created by andhika.setiadi on 01/08/23.
//

import AsyncDisplayKit

internal final class AddressWidgetCellNode: ASCellNode {
    // MARK: Nodes
    
    private let pinImageNode: ASImageNode = {
        let node = ASImageNode()
        node.contentMode = .scaleAspectFit
        node.style.preferredSize = CGSize(width: 20, height: 20)
        return node
    }()
    
    private let titleTextNode = ASTextNode2()
    
    // MARK: Variables
    
    // MARK: Lifecycles
    
    internal override init() {
        super.init()
        
        automaticallyManagesSubnodes = true
        backgroundColor = .white
        style.width = ASDimensionMake("100%")
    }
    
    internal override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let contentStack = ASStackLayoutSpec.horizontal()
        contentStack.spacing = 4
        contentStack.alignItems = .center
        contentStack.justifyContent = .start
        contentStack.children = [
            pinImageNode,
            titleTextNode
        ]
        contentStack.style.flexGrow = 1
        
        let insetStack = ASInsetLayoutSpec(
            insets: UIEdgeInsets(
                top: 16,
                left: 16,
                bottom: 16,
                right: 16
            ),
            child: contentStack
        )
        
        return ASWrapperLayoutSpec(layoutElement: insetStack)
    }
    
    internal func setup(_ address: String) {
        pinImageNode.image = #imageLiteral(resourceName: "push_pin_filled")
        titleTextNode.attributedText = .title(address)
        
        setNeedsLayout()
    }
    
    #if DEBUG
        deinit {
            print(">>> deinit \(String(describing: self))")
        }
    #endif
}
