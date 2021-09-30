//
//  ASCollectionDeinitCellVC.swift
//  TextureVOUI
//
//  Created by Jefferson Setiawan on 30/09/21.
//

import AsyncDisplayKit

internal final class ASCollectionDeinitCellVC: ASDKViewController<ASDisplayNode> {
    
    private var items: [Int] = [0,1,2,3,4,5,6,7,8,9,10]
    private let explanationNode: ASTextNode2 = {
        let textNode = ASTextNode2()
        textNode.attributedText = NSAttributedString(string: """
        Here is the demo of when ASCollectionNode will deinit it's cells.
        If you tap the button, it will reload 2nd row with new data, but the old cell will not be deinit,
        it will deinit if you tap once again.
        Another one, if you scroll until Cell no 2 is not visible and tap the button, the cell will automatically deinit.
        """)
        
        return textNode
    }()
    
    private let collectionNode: ASCollectionNode = {
        let node = ASCollectionNode(collectionViewLayout: UICollectionViewFlowLayout())
        node.backgroundColor = .white
        node.style.flexGrow = 1
        return node
    }()
    
    private let buttonNode: ASButtonNode = {
        let buttonNode = ASButtonNode()
        buttonNode.backgroundColor = .lightGray
        buttonNode.setAttributedTitle(NSAttributedString(string: "Tap to Change cell no 2"), for: .normal)
        buttonNode.style.height = ASDimensionMake(40)
        return buttonNode
    }()
    
    override internal init() {
        super.init(node: ASDisplayNode())
        node.automaticallyManagesSubnodes = true
        node.backgroundColor = .white
        node.layoutSpecBlock = { [weak self] _, _ in
            guard let self = self else { return ASLayoutSpec() }
            let stack = ASStackLayoutSpec.vertical()
            stack.spacing = 16
            stack.children = [self.explanationNode, self.collectionNode, self.buttonNode]
            return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 80, left: 8, bottom: 0, right: 8), child: stack)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionNode.dataSource = self
        collectionNode.delegate = self
        
        buttonNode.addTarget(self, action: #selector(didTap), forControlEvents: .touchUpInside)
    }
    
    @objc private func didTap() {
        items[2] = Int.random(in: 20...1000)
        collectionNode.reloadItems(at: [IndexPath(row: 2, section: 0)])
    }
    
    required internal init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ASCollectionDeinitCellVC: ASCollectionDataSource {
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        items.count
    }

    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        let number = items[indexPath.row]
        return {
            TestCellNode(number: number)
        }
    }
}

extension ASCollectionDeinitCellVC: ASCollectionDelegate {
    func collectionNode(_ collectionNode: ASCollectionNode, constrainedSizeForItemAt indexPath: IndexPath) -> ASSizeRange {
        return ASSizeRange(min: CGSize(width: 320, height: 200), max: CGSize(width: 320, height: 200))
    }
}

class TestCellNode: ASCellNode {
    private let titleNode = ASTextNode()
    private let number: Int
    
    init(number: Int) {
        print("<<< init cell \(number)")
        self.number = number
        super.init()
        automaticallyManagesSubnodes = true
        titleNode.attributedText = NSAttributedString(string: "Cell number \(number)")
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let inset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 40, left: 16, bottom: 40, right: 16), child: titleNode)
        return ASWrapperLayoutSpec(layoutElement: inset)
    }
    
    deinit {
        print("<<< deinit cell \(number)")
    }
}
