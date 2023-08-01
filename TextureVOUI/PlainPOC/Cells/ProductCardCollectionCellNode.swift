//
//  ProductCardCollectionCellNode.swift
//  TextureVOUI
//
//  Created by andhika.setiadi on 01/08/23.
//

import AsyncDisplayKit

internal final class ProductCardCollectionCellNode: ASCellNode {
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
    
    internal var items: [Product] = [] {
        didSet {
            guard oldValue != items else { return }
            
            collectionNode.reloadData()
        }
    }
    
    // MARK: Lifecycles
    
    internal override init() {
        super.init()
        
        automaticallyManagesSubnodes = true
        backgroundColor = .white
        style.width = ASDimensionMake("100%")
        
        /// 200 + 10 bottom content inset
        ///
        style.height = ASDimensionMake(210)
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
    
    internal override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASWrapperLayoutSpec(layoutElement: collectionNode)
    }
    
    #if DEBUG
        deinit {
            print(">>> deinit \(String(describing: self))")
        }
    #endif
}

extension ProductCardCollectionCellNode: ASCollectionDataSource {
    internal func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
        return 1
    }
    
    internal func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    internal func collectionNode(_ collectionNode: ASCollectionNode, nodeForItemAt indexPath: IndexPath) -> ASCellNode {
        guard let data = items[safe: indexPath.row] else { return ASCellNode() }
        
        let cell = ProductCardCellNode()
        cell.setup(data)
        return cell
    }
    
    internal func collectionNode(_ collectionNode: ASCollectionNode, constrainedSizeForItemAt indexPath: IndexPath) -> ASSizeRange {
        return ASSizeRange(
            min: CGSize.zero,
            max: CGSize(
                width: 100,
                height: 200
            )
        )
    }
}

extension ProductCardCollectionCellNode: ASCollectionDelegate {}

// MARK: Cell Class Node

fileprivate final class ProductCardCellNode: ASCellNode {
    // MARK: Nodes
    
    private let productImageNode: ASImageNode = {
        let node = ASImageNode()
        node.contentMode = .scaleToFill
        node.onDidLoad {
            $0.layer.cornerRadius = 8
        }
        node.clipsToBounds = true
        return node
    }()
    
    private let titleTextNode = ASTextNode2()
    private let weightTextNode = ASTextNode2()
    
    // MARK: Variables
    
    // MARK: Lifecycles
    
    internal override init() {
        super.init()
        
        automaticallyManagesSubnodes = true
    }
    
    internal override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let size = max(0, constrainedSize.max.width)
        productImageNode.style.preferredSize = CGSize(width: size, height: size)
        
        let contentStack = ASStackLayoutSpec.vertical()
        contentStack.spacing = 8
        contentStack.alignItems = .start
        contentStack.children = [
            productImageNode,
            titleTextNode,
            weightTextNode
        ]
        
        return ASWrapperLayoutSpec(layoutElement: contentStack)
    }
    
    internal func setup(_ product: Product) {
        productImageNode.image = UIImage(named: product.image)
        productImageNode.layoutIfNeeded()
        
        titleTextNode.attributedText = .title(product.title)
        weightTextNode.attributedText = .title(product.weight)
    }
    
    #if DEBUG
        deinit {
            print(">>> deinit \(String(describing: self))")
        }
    #endif
}
