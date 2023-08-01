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
    
    internal var items: [Category] = [] {
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
        
        /// 120 + 10 bottom content inset
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
    
    internal override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASWrapperLayoutSpec(layoutElement: collectionNode)
    }
    
    #if DEBUG
        deinit {
            print(">>> deinit \(String(describing: self))")
        }
    #endif
}

extension CategoryWidgetCollectionCellNode: ASCollectionDataSource {
    internal func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
        return 1
    }
    
    internal func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    internal func collectionNode(_ collectionNode: ASCollectionNode, nodeForItemAt indexPath: IndexPath) -> ASCellNode {
        guard let data = items[safe: indexPath.row] else { return ASCellNode() }
        
        let cell = CategoryWidgetCellNode()
        cell.setup(data)
        return cell
    }
    
    internal func collectionNode(_ collectionNode: ASCollectionNode, constrainedSizeForItemAt indexPath: IndexPath) -> ASSizeRange {
        return ASSizeRange(
            min: CGSize.zero,
            max: CGSize(
                width: 70,
                height: 120
            )
        )
    }
}

extension CategoryWidgetCollectionCellNode: ASCollectionDelegate {}

// MARK: Cell Class Node

fileprivate final class CategoryWidgetCellNode: ASCellNode {
    // MARK: Nodes
    
    private let categoryImageNode: ASImageNode = {
        let node = ASImageNode()
        node.contentMode = .scaleAspectFill
        node.onDidLoad {
            $0.layer.cornerRadius = 8
        }
        node.clipsToBounds = true
        return node
    }()
    
    private let titleTextNode = ASTextNode2()
    
    // MARK: Variables
    
    // MARK: Lifecycles
    
    internal override init() {
        super.init()
        
        automaticallyManagesSubnodes = true
    }
    
    internal override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let size = max(0, constrainedSize.max.width)
        categoryImageNode.style.preferredSize = CGSize(width: size, height: size)
        
        let contentStack = ASStackLayoutSpec.vertical()
        contentStack.spacing = 8
        contentStack.alignItems = .center
        contentStack.children = [
            categoryImageNode,
            titleTextNode
        ]
        
        return ASWrapperLayoutSpec(layoutElement: contentStack)
    }
    
    internal func setup(_ category: Category) {
        categoryImageNode.image = UIImage(named: category.image)
        categoryImageNode.layoutIfNeeded()
        
        titleTextNode.attributedText = .title(category.title, alignment: .center)
    }
    
    #if DEBUG
        deinit {
            print(">>> deinit \(String(describing: self))")
        }
    #endif
}
