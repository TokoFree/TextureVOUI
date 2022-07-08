//
//  DemoAncestorTextureVC.swift
//  TextureVOUI
//
//  Created by jefferson.setiawan on 07/04/22.
//

import AsyncDisplayKit

internal final class DemoAncestorTextureVC: ASDKViewController<ASDisplayNode> {
    private let node1 = ASDisplayNode()
    private let node2 = ASDisplayNode()
    private let node3 = ASDisplayNode()
    private let node4 = ASDisplayNode()
    
    override internal init() {
        super.init(node: ASDisplayNode())
        node.backgroundColor = .white
        
        node1.backgroundColor = .orange
        node2.backgroundColor = .red
        node3.backgroundColor = .green
        node4.backgroundColor = .blue
        
        node1.style.preferredSize = CGSize(width: 200, height: 200)
        node2.style.preferredSize = CGSize(width: 100, height: 100)
        node3.style.preferredSize = CGSize(width: 50, height: 50)
        node4.style.preferredSize = CGSize(width: 20, height: 20)
        /*
         node = PdpContentNode
         node1 = ListStoreNode
         node2 = ListStoreCellNode
         node3 = SwitchCaseStoreNode
         node4 = PdpTCAMediaNode ...
         */
        node.addSubnode(node1)
        node1.addSubnode(node2)
        node2.addSubnode(node3)
        node3.addSubnode(node4)
        
        node1.layoutSpecBlock = { [unowned self] _, _ in
            ASInsetLayoutSpec(insets: UIEdgeInsets(top: 16, left: 16, bottom: .infinity, right: .infinity), child: node2)
        }
        
        node2.layoutSpecBlock = { [unowned self] _, _ in
            ASInsetLayoutSpec(insets: UIEdgeInsets(top: 30, left: 30, bottom: .infinity, right: .infinity), child: node3)
        }
        
        node3.layoutSpecBlock = { [unowned self] _, _ in
            ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10, left: 10, bottom: .infinity, right: .infinity), child: node4)
        }
        node.layoutSpecBlock = { [unowned self] _, _ in
            let inset1 = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 8, left: 8, bottom: .infinity, right: .infinity), child: node1)
            return ASWrapperLayoutSpec(layoutElement: inset1)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let node4FrameFromNode1 = node4.convert(node3.bounds, to: node)
        print(node4FrameFromNode1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

internal final class DemoAncestorTextureCollectionVC: ASDKViewController<ASDisplayNode> {
    private let explanationNode: ASTextNode2 = {
        let node = ASTextNode2()
        node.attributedText = .body("""
        Demo on ASCollectionNode doesn't have hierarchy of ASCellNode when trying to use `ASDisplayNode.convert` function on ASDisplayNode
        Terminating app due to uncaught exception 'NSInternalInconsistencyException', reason: 'Could not find a common ancestor between node1: <Cell> and node2: <ASCollectionNode>'. Sample case is found in Pdp when trying to implement Navigation anchor.
        To Prevent the crash, use UIView.convert instead on ASDisplayNode.view (The connection between cell and collection is in ASCollectionView not in ASCollectionNode. Try to comment line 106 and uncomment line 107
        """)
        return node
    }()
    
    private let colNode: ASCollectionNode = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = UICollectionView.ScrollDirection.vertical
        let node = ASCollectionNode(collectionViewLayout: layout)
        node.backgroundColor = .white
        return node
    }()
    
    private var data: [Int] = Array(1...100)
    
    override internal init() {
        super.init(node: ASDisplayNode())
        colNode.backgroundColor = .white
        colNode.style.flexGrow = 1
        
        node.automaticallyManagesSubnodes = true
        node.layoutSpecBlock = { [unowned self] _, _ in
            ASStackLayoutSpec(direction: .vertical, spacing: 8, justifyContent: .start, alignItems: .stretch, children: [explanationNode, colNode])
        }
        node.backgroundColor = .white
        
        colNode.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let node2 = colNode.nodeForItem(at: IndexPath(row: 1, section: 0))!
//        print(node2.convert(node2.bounds, to: colNode)) // 💣 Crash
        print(node2.view.convert(node2.bounds, to: colNode.view))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DemoAncestorTextureCollectionVC: ASCollectionDataSource {
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        let num = data[indexPath.row]
        return {
            MyCellNode(number: num)
        }
    }
}

internal final class MyCellNode: ASCellNode {
    internal let textNode = ASTextNode2()
    
    init(number: Int) {
        super.init()
        automaticallyManagesSubnodes = true
        backgroundColor = .yellow
        style.flexGrow = 1
        
        textNode.attributedText = .body("Text ke \(number)")
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        ASStackLayoutSpec(direction: .vertical, spacing: 8, justifyContent: .start, alignItems: .start, children: [textNode])
    }
}

internal final class DemoScrollHorizontalVC: ASDKViewController<ASDisplayNode> {
    private let explanationNode: ASTextNode2 = {
        let node = ASTextNode2()
        node.attributedText = .body("""
        Demo on ScrollNode horizontal
        """)
        return node
    }()
    
    private let hScrollNode: ASScrollNode = {
        let scroll = ASScrollNode()
        scroll.scrollableDirections = [.left, .right]
        scroll.automaticallyManagesSubnodes = true
        scroll.automaticallyManagesContentSize = true
        return scroll
    }()
    
    private let text1: ASTextNode2 = {
        let node = ASTextNode2()
        node.attributedText = .body("""
        Text 1st
        """)
        return node
    }()
    private let text2: ASTextNode2 = {
        let node = ASTextNode2()
        node.attributedText = .body("""
        Ini Text ke dua yg lumayan panjang
        """)
        return node
    }()
    private let text3: ASTextNode2 = {
        let node = ASTextNode2()
        node.attributedText = .body("""
        Text 3rd
        """)
        return node
    }()
    private let text4: ASTextNode2 = {
        let node = ASTextNode2()
        node.attributedText = .body("""
        Text 4th
        """)
        return node
    }()
    
    override init() {
        super.init(node: ASDisplayNode())
        node.backgroundColor = .white
        node.automaticallyManagesSubnodes = true
        node.layoutSpecBlock = { [unowned self] _, _ in
            let stack = ASStackLayoutSpec.vertical()
            stack.children = [explanationNode, hScrollNode]
            return stack
        }
        node.setNeedsLayout()
        hScrollNode.layoutSpecBlock = { [unowned self] _, _ in
            ASStackLayoutSpec(direction: .horizontal, spacing: 16, justifyContent: .start, alignItems: .start, children: [text1, text2, text3, text4])
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
