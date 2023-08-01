//
//  PromoWidgetCollectionCellNode.swift
//  TextureVOUI
//
//  Created by andhika.setiadi on 01/08/23.
//

import AsyncDisplayKit

internal final class PromoWidgetCollectionCellNode: ASCellNode {
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
    
    internal var items: [String] = [] {
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
        collectionNode.view.isPagingEnabled = true
        
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

extension PromoWidgetCollectionCellNode: ASCollectionDataSource {
    internal func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
        return 1
    }
    
    internal func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    internal func collectionNode(_ collectionNode: ASCollectionNode, nodeForItemAt indexPath: IndexPath) -> ASCellNode {
        guard let data = items[safe: indexPath.row] else { return ASCellNode() }
        
        let cell = PromoWidgetCellNode()
        cell.setup(data)
        return cell
    }
    
    internal func collectionNode(_ collectionNode: ASCollectionNode, constrainedSizeForItemAt indexPath: IndexPath) -> ASSizeRange {
        return ASSizeRange(
            min: CGSize.zero,
            max: CGSize(
                width: collectionNode.calculatedSize.width - 48, /// 32 contentInset + 16 for sneak peek image
                height: 200
            )
        )
    }
}

extension PromoWidgetCollectionCellNode: ASCollectionDelegate {}

// MARK: Cell Class Node

fileprivate final class PromoWidgetCellNode: ASCellNode {
    // MARK: Nodes
    
    private let bannerImageNode: ASImageNode = {
        let node = ASImageNode()
        node.contentMode = .scaleToFill
        node.onDidLoad {
            $0.layer.cornerRadius = 8
        }
        node.clipsToBounds = true
        return node
    }()
    
    // MARK: Variables
    
    // MARK: Lifecycles
    
    internal override init() {
        super.init()
        
        automaticallyManagesSubnodes = true
    }
    
    internal override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASWrapperLayoutSpec(layoutElement: bannerImageNode)
    }
    
    internal func setup(_ image: String) {
        bannerImageNode.image = UIImage(named: image)
        bannerImageNode.layoutIfNeeded()
    }
    
    #if DEBUG
        deinit {
            print(">>> deinit \(String(describing: self))")
        }
    #endif
}
