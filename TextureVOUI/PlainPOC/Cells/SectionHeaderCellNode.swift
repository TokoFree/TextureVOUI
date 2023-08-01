//
//  SectionHeaderCellNode.swift
//  TextureVOUI
//
//  Created by andhika.setiadi on 01/08/23.
//

import AsyncDisplayKit

internal final class SectionHeaderCellNode: ASCellNode {
    // MARK: Nodes
    
    private let titleTextNode = ASTextNode2()
    private let seeAllTextNode = ASTextNode2()
    
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
        contentStack.justifyContent = .spaceBetween
        contentStack.children = [
            titleTextNode,
            seeAllTextNode
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
    
    internal func setup(_ title: String, detail: String) {
        titleTextNode.attributedText = .title(title, isBold: true)
        seeAllTextNode.attributedText = .body(detail, color: .systemGreen)
    }
    
    #if DEBUG
        deinit {
            print(">>> deinit \(String(describing: self))")
        }
    #endif
}
