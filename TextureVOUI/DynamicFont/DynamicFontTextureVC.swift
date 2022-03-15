//
//  DynamicFontTextureVC.swift
//  TextureVOUI
//
//  Created by jefferson.setiawan on 15/03/22.
//

import AsyncDisplayKit

internal final class DynamicFontTextureVC: ASDKViewController<ASScrollNode> {
    
    private let textNode = ASTextNode()
    override init() {
        super.init(node: ASScrollNode())
        node.automaticallyManagesContentSize = true
        node.automaticallyManagesSubnodes = true
        node.backgroundColor = .white
        node.layoutSpecBlock = { [unowned self] _, _ in
            return ASWrapperLayoutSpec(layoutElement: self.textNode)
        }
        let attr = NSAttributedString.setFont(font: UIFont.preferredFont(forTextStyle: .title1), color: .black, alignment: .left, strikethrough: false)
        textNode.attributedText = NSMutableAttributedString(string: "This is attributed text", attributes: attr)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
