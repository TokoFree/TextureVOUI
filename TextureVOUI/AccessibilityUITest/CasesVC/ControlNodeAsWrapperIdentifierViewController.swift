//
//  ControlNodeAsWrapperIdentifierViewController.swift
//  TextureVOUI
//
//  Created by andhika.setiadi on 13/12/21.
//

import AsyncDisplayKit

internal final class ControlNodeAsWrapperIdentifierViewController: ASDKViewController<ASDisplayNode> {
    
    private let rootNode: ASDisplayNode = {
        let node = ASDisplayNode()
        node.automaticallyManagesSubnodes = true
        node.accessibilityIdentifier = "ParentNodeWrapper"
        return node
    }()
    
    private let dummyNode: ASControlNode = {
        let node = ASControlNode()
        node.automaticallyManagesSubnodes = true
        node.style.preferredSize = CGSize(width: 200, height: 200)
        node.accessibilityIdentifier = "ControlNodeWrapper"
        
        let node1 = ASTextNode2()
        node1.attributedText = .body("Pengiriman", color: .white)
        node1.accessibilityIdentifier = "pengirimanLabel"
        
        node.layoutSpecBlock = { _, _ in
            return ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: node1)
        }
        return node
    }()
    
    override internal init() {
        super.init(node: rootNode)
        
        rootNode.layoutSpecBlock = { [weak self] _, _ in
            guard let self = self else { return ASLayoutSpec() }
            
            return ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: self.dummyNode)
        }
    }
    
    internal override func viewDidLoad() {
        super.viewDidLoad()
        
        // NOTE: these are is why the ASControlNode auto-apply grouping identifier
        // you cant try uncomment one of each this setup to try yourself
        
        // 1. set onPress listener
        // dummyNode.addTarget(self, action: #selector(onPress), forControlEvents: .touchUpInside)
        
        // 2. set isUserInteractionEnabled
        // if value true will force ASControlNode to grouping, if false, will act like normal ASDisplayNode
        // dummyNode.isUserInteractionEnabled = true
        
        // but if we set isEnabled, it will not change any grouping accessibility
        // dummyNode.isEnabled = true
    }
    
    @objc private func onPress() {
        print("OnPress Text")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
