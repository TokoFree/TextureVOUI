//
//  CategoryWidgetCollectionCellNode.swift
//  TextureVOUI
//
//  Created by andhika.setiadi on 01/08/23.
//

import AsyncDisplayKit

internal final class CategoryWidgetCollectionCellNode: ASCellNode {
    // MARK: Nodes
    
    private let collectionLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        return layout
    }()

    private lazy var collectionNode = ASCollectionNode(
        collectionViewLayout: collectionLayout
    )
    
    // MARK: Variables
    
    // MARK: Lifecycles
    
    internal override init() {
        super.init()
        
        automaticallyManagesSubnodes = true
        backgroundColor = .white
        style.width = ASDimensionMake("100%")
        
        /// 200 + 10 bottom content inset
        ///
        style.height = ASDimensionMake(130)
    }
    
    internal override func didLoad() {
        super.didLoad()
        
        collectionNode.contentInset = UIEdgeInsets(
            top: 0,
            left: 16,
            bottom: 10,
            right: 16
        )
        collectionNode.view.showsHorizontalScrollIndicator = false
        
        collectionNode.delegate = self
        collectionNode.dataSource = self
    }
    
    #if DEBUG
        deinit {
            print(">>> deinit \(String(describing: self))")
        }
    #endif
}
