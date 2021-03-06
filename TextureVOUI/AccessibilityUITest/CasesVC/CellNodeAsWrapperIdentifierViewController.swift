//
//  CellNodeAsWrapperIdentifierViewController.swift
//  TextureVOUI
//
//  Created by andhika.setiadi on 15/12/21.
//

import AsyncDisplayKit

internal final class CellNodeAsWrapperIdentifierViewController: ASDKViewController<ASTableNode> {
    
    private let tableNode: ASTableNode = {
        let node = ASTableNode(style: .plain)
        node.accessibilityIdentifier = "tableNodeWrapper"
        return node
    }()
    
    override internal init() {
        super.init(node: tableNode)
    }
    
    internal override func viewDidLoad() {
        super.viewDidLoad()
        
        tableNode.backgroundColor = .white
        
        tableNode.dataSource = self
        tableNode.delegate = self
    }
    
    required internal init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CellNodeAsWrapperIdentifierViewController: ASTableDataSource {
    internal func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    internal func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        return {
            let node = DummyAccessibleCellNode(index: indexPath.row)
            return node
        }
    }
}

extension CellNodeAsWrapperIdentifierViewController: ASTableDelegate {
//    internal func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
//        print("item at \(indexPath.row)")
//    }
}

// MARK: Dummy CellNode with many child

internal final class DummyAccessibleCellNode: ASCellNode {
    
    private let codLabelNode: ASDisplayNode = {
        let textNode = ASTextNode2()
        textNode.attributedText = .body("Cash on delivery", color: .red)
        textNode.accessibilityIdentifier = "codLabel"
        
        let node = ASDisplayNode()
        node.backgroundColor = .green
        node.automaticallyManagesSubnodes = true
        node.layoutSpecBlock = { _, _ in
            return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4), child: textNode)
        }
        node.onDidLoad {
            $0.layer.cornerRadius = 4
        }
        return node
    }()
    
    private let dynamicLabelNode: ASDisplayNode = {
        let textNode = ASTextNode2()
        textNode.attributedText = .body("Dynamic", color: .red)
        textNode.accessibilityIdentifier = "dynamicLabel"
        
        let node = ASDisplayNode()
        node.backgroundColor = .green
        node.automaticallyManagesSubnodes = true
        node.layoutSpecBlock = { _, _ in
            return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4), child: textNode)
        }
        node.onDidLoad {
            $0.layer.cornerRadius = 4
        }
        return node
    }()
    
    private let estimationTextNode: ASTextNode2 = {
        let textNode = ASTextNode2()
        textNode.attributedText = .body("Estimasi tiba 27 Sep - 29 Sep", color: .black)
        textNode.accessibilityIdentifier = "estimationText"
        return textNode
    }()
    
    private let cellIndex: Int
    
    internal init(index: Int) {
        self.cellIndex = index
        
        super.init()
        
        accessibilityIdentifier = "CellNodeWrapper"
        
        if cellIndex == 1 {
            accessibilityLabel = "COD Dynamic, estimasi tiba pada 27 September sampai dengan 29 September"
        } else {
            accessibilityLabel = "estimasi tiba pada 27 September sampai dengan 29 September"
        }
        
        automaticallyManagesSubnodes = true
    }
    
    internal override func didLoad() {
        super.didLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onPress))
        view.addGestureRecognizer(tapGesture)
    }
    
    override internal func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        var children: [ASLayoutElement] = [estimationTextNode]
        
        if cellIndex == 1 {
            children = [
                codLabelNode,
                estimationTextNode,
                dynamicLabelNode
            ]
        }
        
        let stack = ASStackLayoutSpec.vertical()
        stack.justifyContent = .start
        stack.alignItems = .start
        stack.spacing = 4
        stack.children = children
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8), child: stack)
    }
    
    @objc func onPress() {
        print("pressed cell - \(cellIndex)")
    }
}
