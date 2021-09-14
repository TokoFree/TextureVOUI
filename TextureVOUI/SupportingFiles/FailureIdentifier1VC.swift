//
//  FailureIdentifier1VC.swift
//  TextureVOUI
//
//  Created by Nakama on 14/09/21.
//

import AsyncDisplayKit

class FailureIdentifier1VC: ASDKViewController<ASDisplayNode> {
    private let dummyNode3: ASDisplayNode = {
        let dummyNode = ASDisplayNode()
        dummyNode.style.preferredSize = CGSize(width: 50, height: 50)
        dummyNode.backgroundColor = .yellow
        // NOTE: we need to force the element as container
        dummyNode.isAccessibilityElement = true
        dummyNode.accessibilityIdentifier = "yellow-box-identifier"
        return dummyNode
    }()
    
    private let dummyInputNode2: ASEditableTextNode = {
        let dummyNode2 = ASEditableTextNode()
        dummyNode2.style.preferredSize = CGSize(width: 100, height: 100)
        dummyNode2.backgroundColor = .green
        dummyNode2.accessibilityIdentifier = "green-box-textInput-identifier"
        return dummyNode2
    }()
    
    private let dummyNode4: ASDisplayNode = {
        let dummyNode = ASDisplayNode()
        dummyNode.automaticallyManagesSubnodes = true
        dummyNode.style.preferredSize = CGSize(width: 50, height: 50)
        dummyNode.backgroundColor = .cyan
        // NOTE: we need to force the element as container
        dummyNode.isAccessibilityElement = true
        dummyNode.accessibilityIdentifier = "cyan-box-identifier"
        
        let dummyNode2 = ASDisplayNode()
        dummyNode2.backgroundColor = .brown
        dummyNode2.isAccessibilityElement = true
        dummyNode2.style.preferredSize = CGSize(width: 150, height: 150)
        dummyNode2.accessibilityIdentifier = "brown-nested-box-identifier"
        
        dummyNode.layoutSpecBlock = { _,_ in
            return ASWrapperLayoutSpec(layoutElement: dummyNode2)
        }
        
        return dummyNode
    }()
    
    private let controlTestNode2: ASControlNode = {
        let wrapperNode = ASControlNode()
        wrapperNode.automaticallyManagesSubnodes = true
        
        let dummyNode = ASDisplayNode()
        dummyNode.style.preferredSize = CGSize(width: 50, height: 50)
        dummyNode.backgroundColor = .gray
        // NOTE: we need to force the element as container
        dummyNode.isAccessibilityElement = true
        dummyNode.accessibilityIdentifier = "gray-box-identifier"
        let dummyNode2 = ASEditableTextNode()
        dummyNode2.style.preferredSize = CGSize(width: 100, height: 100)
        dummyNode2.backgroundColor = .magenta
        dummyNode2.accessibilityIdentifier = "magenta-box-textInput-identifier"
        
        wrapperNode.layoutSpecBlock = { _,_ in
            let stack = ASStackLayoutSpec.vertical()
            stack.spacing = 16
            stack.children = [
                dummyNode,
                dummyNode2
            ]
            return stack
        }
        return wrapperNode
    }()
    
    private let controlTestNode: ASControlNode = {
        let wrapperNode = ASControlNode()
        wrapperNode.automaticallyManagesSubnodes = true
        // We test is to force the isAccessibilityElement became true
        wrapperNode.isAccessibilityElement = true
        
        let dummyNode = ASDisplayNode()
        dummyNode.style.preferredSize = CGSize(width: 50, height: 50)
        dummyNode.backgroundColor = .red
        // NOTE: we need to force the element as container
        dummyNode.isAccessibilityElement = true
        dummyNode.accessibilityIdentifier = "red-box-identifier"
        let dummyNode2 = ASEditableTextNode()
        dummyNode2.style.preferredSize = CGSize(width: 100, height: 100)
        dummyNode2.backgroundColor = .blue
        dummyNode2.accessibilityIdentifier = "blue-box-textInput-identifier"
        
        wrapperNode.layoutSpecBlock = { _,_ in
            let stack = ASStackLayoutSpec.vertical()
            stack.spacing = 16
            stack.children = [
                dummyNode,
                dummyNode2
            ]
            return stack
        }
        return wrapperNode
    }()
    
    override init() {
        super.init(node: ASDisplayNode())
        node.backgroundColor = .systemBackground
        node.automaticallyManagesSubnodes = true
        
        node.layoutSpecBlock = { [unowned self] _, _ in
            let stack = ASStackLayoutSpec.vertical()
            stack.spacing = 16
            stack.children = [
                controlTestNode,
                dummyNode3,
                dummyInputNode2,
                dummyNode4,
                controlTestNode2
            ]
            
            return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 100, left: 0, bottom: 0, right: 0), child: stack)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
