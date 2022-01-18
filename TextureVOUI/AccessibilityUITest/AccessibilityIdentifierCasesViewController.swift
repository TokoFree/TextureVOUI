//
//  AccessibilityIdentifierCasesViewController.swift
//  TextureVOUI
//
//  Created by andhika.setiadi on 13/12/21.
//

import AsyncDisplayKit

internal final class AccessibilityIdentifierCasesViewController: ASDKViewController<ASTableNode> {
    
    // MARK: Nodes
    
    private let tableNode: ASTableNode = {
        let node = ASTableNode(style: .insetGrouped)
        return node
    }()
    
    // MARK: Variables
    
    private enum CasesExample: String, CaseIterable {
        case controlNode = "Identifier in ASControlNode Parent"
        case cellNode = "Identifier in ASCellNode Parent"
        case tooNested = "Identifier on Nested UI"
    }
    
    private let cases: [CasesExample] = CasesExample.allCases
    
    override internal init() {
        super.init(node: tableNode)
    }
    
    internal override func viewDidLoad() {
        super.viewDidLoad()
        
        tableNode.delegate = self
        tableNode.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AccessibilityIdentifierCasesViewController: ASTableDataSource {
    internal func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return cases.count
    }
    
    internal func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
        guard cases.count > 0 else { return ASCellNode()}
        
        let node = ASTextCellNode()
        node.text = cases[indexPath.row].rawValue
        return node
    }
}

extension AccessibilityIdentifierCasesViewController: ASTableDelegate {
    internal func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        let selectedCases = cases[indexPath.row]
        
        switch selectedCases {
        case .controlNode:
            navigationController?.pushViewController(ControlNodeAsWrapperIdentifierViewController(), animated: true)
        case .cellNode:
            navigationController?.pushViewController(CellNodeAsWrapperIdentifierViewController(), animated: true)
        case .tooNested:
            navigationController?.pushViewController(TooNestedExampleViewController(), animated: true)
        }
    }
}
