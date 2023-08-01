//
//  RouteVC.swift
//  TextureVOUI
//
//  Created by Jefferson Setiawan on 13/09/21.
//

import UIKit

public final class RouteVC: UITableViewController {
    private enum Route: String, CaseIterable {
        case collectionViewSection = "UICollectionView with Section"
        case collectionNodeSection = "ASCollectionNode with Section"
        case dynamicFontUikit = "Dynamic font UIKit"
        case dynamicFontTexture = "Dynamic font Texture"
        case wrappingUsingControlNode = "Using ASControlNode to Wrap Layout"
        case voiceOverActivationPoint = "Voice Over Activation Point"
        case uiTestRoute = "UITest Accessibility Cases Example"
        case textureIssue = "⚠️ Texture Issue"
        case plainTextureCollection = "CollectionNode POC"
    }

    private let routes: [Route] = Route.allCases

    public init() {
        super.init(style: .insetGrouped)

        title = "Texture UITest Issue"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    override public func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let selectedRoute = routes[indexPath.row]
        switch selectedRoute {
        case .dynamicFontUikit:
            navigationController?.pushViewController(DynamicFontUIKitVC(), animated: true)
        case .dynamicFontTexture:
            navigationController?.pushViewController(DynamicFontTextureVC(), animated: true)
        case .wrappingUsingControlNode:
            navigationController?.pushViewController(FailureIdentifier1VC(), animated: true)
        case .voiceOverActivationPoint:
            navigationController?.pushViewController(ActivationPointVC(), animated: true)
        case .uiTestRoute:
            navigationController?.pushViewController(AccessibilityIdentifierCasesViewController(), animated: true)
        case .textureIssue:
            navigationController?.pushViewController(TextureIssueRouteVC(), animated: true)
        case .collectionViewSection:
            navigationController?.pushViewController(CollectionWithSectionVC(), animated: true)
        case .collectionNodeSection:
            navigationController?.pushViewController(CollectionWithSectionNodeVC(), animated: true)
        case .plainTextureCollection:
            navigationController?.pushViewController(PlainCollectionViewController(), animated: true)
        }
    }

    override public func tableView(_: UITableView, numberOfRowsInSection: Int) -> Int {
        return routes.count
    }

    override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = routes[indexPath.row].rawValue
        return cell
    }

    internal required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
