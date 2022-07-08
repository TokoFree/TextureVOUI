//
//  DynamicFontTextureVC.swift
//  TextureVOUI
//
//  Created by jefferson.setiawan on 15/03/22.
//

import AsyncDisplayKit

internal final class DynamicFontTextureVC: ASDKViewController<ASDisplayNode> {
    
//    private let textNode = ASTextNode()
    override init() {
        super.init(node: ASDisplayNode())
//        node.automaticallyManagesContentSize = true
//        node.automaticallyManagesSubnodes = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.node.backgroundColor = .red
            self.node.addSubnode(ASDisplayNode())
//            node.layoutSpecBlock = {
//
//            }
            
            let asd = ASLayoutSpec()
            asd.style.height = ASDimensionMake(1)
        }
        
//        node.layoutSpecBlock = { [unowned self] _, _ in
//            return ASWrapperLayoutSpec(layoutElement: self.textNode)
//        }
//        let attr = NSAttributedString.setFont(font: UIFont.preferredFont(forTextStyle: .title1), color: .black, alignment: .left, strikethrough: false)
//        textNode.attributedText = NSMutableAttributedString(string: "This is attributed text", attributes: attr)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
