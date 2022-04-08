//
//  UIViewConvertRouteVC.swift
//  TextureVOUI
//
//  Created by jefferson.setiawan on 08/04/22.
//

import UIKit

public final class UIViewConvertRouteVC: UITableViewController {
    private enum Route: String, CaseIterable {
        case uiKitUiView = "UIKit UIView"
        case uiKitCollectionView = "UIKit UICollectionView"
        case textureDisplayNode = "Texture ASDisplayNode"
        case textureCollectionNode = "Texture ASCollectionNode"
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
        case .uiKitUiView:
            navigationController?.pushViewController(DemoAncestorUIKitVC(), animated: true)
        case .uiKitCollectionView:
            navigationController?.pushViewController(DemoAncestorCollectionUIKitVC(), animated: true)
        case .textureDisplayNode:
            navigationController?.pushViewController(DemoAncestorTextureVC(), animated: true)
        case .textureCollectionNode:
            navigationController?.pushViewController(DemoAncestorTextureCollectionVC(), animated: true)
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
