//
//  CollectionWithSectionNodeVC.swift
//  TextureVOUI
//
//  Created by jefferson.setiawan on 28/07/22.
//

import AsyncDisplayKit

final class CollectionWithSectionNodeVC: ASDKViewController<ASCollectionNode> {
    private let sections: [[Int]] = [
        [1,2,3],
        [10,11,12,13]
    ]
    override init() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 140, height: 20)
        super.init(node: ASCollectionNode(frame: .zero, collectionViewLayout: layout))
        node.delegate = self
        node.dataSource = self
        node.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CollectionWithSectionNodeVC: ASCollectionDelegate {
    func collectionNode(_ collectionNode: ASCollectionNode, didSelectItemAt indexPath: IndexPath) {
        print("<<< select node \(indexPath)")
    }
}

extension CollectionWithSectionNodeVC: ASCollectionDataSource {
    func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
        sections.count
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        sections[section].count
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        let number = sections[indexPath.section][indexPath.row]
        return {
            MySectionCellNode(number: number)
        }
    }
}


class MySectionCellNode: ASCellNode {
    private let titleNode = ASTextNode2()
    init(number: Int) {
        super.init()
        automaticallyManagesSubnodes = true
        titleNode.attributedText = .body("CellNode number \(number)")
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        ASWrapperLayoutSpec(layoutElement: titleNode)
    }
}
