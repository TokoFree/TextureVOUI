//
//  PlainCollectionViewController.swift
//  TextureVOUI
//
//  Created by andhika.setiadi on 01/08/23.
//

import AsyncDisplayKit
import UIKit

internal final class PlainCollectionViewController: ASDKViewController<ASDisplayNode> {
    // MARK: Nodes
    
    private let rootNode: ASDisplayNode = {
        let node = ASDisplayNode()
        node.automaticallyManagesSubnodes = true
        node.backgroundColor = .white
        return node
    }()

    private let collectionLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        return layout
    }()

    private lazy var collectionNode = ASCollectionNode(
        collectionViewLayout: collectionLayout
    )
    
    private let searchBarView: UISearchBar = {
        let view = UISearchBar()
        view.placeholder = "Search"
        view.showsCancelButton = false
        return view
    }()
    
    private let tableNode = ASTableNode(style: .plain)
    
    // MARK: Variables
    
    private let sections = MockData.shared.pageData
    
    // MARK: Lifecycles
    
    internal override init() {
        super.init(node: rootNode)
        
        rootNode.layoutSpecBlock = { [weak self] _,_ in
            guard let self = self else { return ASLayoutSpec() }
            return ASWrapperLayoutSpec(layoutElement: self.collectionNode)
        }
    }
    
    required internal init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollection()
        setupNavbar()
    }
    
    private func setupCollection() {
        collectionNode.delegate = self
        collectionNode.dataSource = self
        
        /// register kind of header
        ///
        collectionNode.registerSupplementaryNode(ofKind: UICollectionView.elementKindSectionHeader)
    }
    
    private func setupNavbar() {
        searchBarView.delegate = self
        searchBarView.sizeToFit()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left")?.withRenderingMode(.alwaysOriginal),
            style: .plain,
            target: nil,
            action: nil
        )
        navigationItem.titleView = searchBarView
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(
                image: UIImage(named: "message")?.withRenderingMode(.alwaysOriginal),
                style: .plain,
                target: nil,
                action: nil
            ),
            UIBarButtonItem(
                image: UIImage(named: "bell_ring")?.withRenderingMode(.alwaysOriginal),
                style: .plain,
                target: nil,
                action: nil
            ),
            UIBarButtonItem(
                image: UIImage(named: "cart")?.withRenderingMode(.alwaysOriginal),
                style: .plain,
                target: nil,
                action: nil
            )
        ]
    }
    
    #if DEBUG
        deinit {
            print(">>> deinit \(String(describing: self))")
        }
    #endif
}

extension PlainCollectionViewController: ASCollectionDataSource {
    internal func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
        sections.count
    }
    
    internal func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    internal func collectionNode(_ collectionNode: ASCollectionNode, supplementaryElementKindsInSection section: Int) -> [String] {
        guard let sectionType = sections[safe: section] else { return [] }
        
        switch sectionType {
        case .categoryWidget, .productCardWidget:
            return [UICollectionView.elementKindSectionHeader]
        case .addressWidget, .promoWidget:
            return []
        }
    }
    
    internal func collectionNode(_ collectionNode: ASCollectionNode, nodeForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> ASCellNode {
        guard let sectionType = sections[safe: indexPath.section] else { return ASCellNode() }
        
        switch sectionType {
        case .categoryWidget, .productCardWidget:
            let node = SectionHeaderCellNode()
            node.setup(sectionType.title, detail: "Lihat Semua")
            return node
            
        case .addressWidget, .promoWidget:
            return ASCellNode()
        }
    }
    
    internal func collectionNode(_ collectionNode: ASCollectionNode, nodeForItemAt indexPath: IndexPath) -> ASCellNode {
        guard let sectionType = sections[safe: indexPath.section] else { return ASCellNode() }
        
        switch sectionType {
        case let .addressWidget(addressData):
            let cell = AddressWidgetCellNode()
            cell.setup(addressData)
            return cell
            
        case let .promoWidget(bannerImages):
            print(">> dbg: masuk sini promoWidget")
            let cell = PromoWidgetCollectionCellNode()
            cell.items = bannerImages
            return cell
            
        case .categoryWidget:
            return ASCellNode()
            
        case .productCardWidget:
            return ASCellNode()
        }
    }
    
    internal func collectionNode(_ collectionNode: ASCollectionNode, constrainedSizeForItemAt indexPath: IndexPath) -> ASSizeRange {
        ASSizeRangeUnconstrained
    }
}

extension PlainCollectionViewController: ASCollectionDelegateFlowLayout {
    internal func collectionNode(_: ASCollectionNode, sizeRangeForHeaderInSection _: Int) -> ASSizeRange {
        ASSizeRangeUnconstrained
    }
}

extension PlainCollectionViewController: ASCollectionDelegate {}

extension PlainCollectionViewController: UISearchBarDelegate {
    internal func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {}
    internal func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {}
}
