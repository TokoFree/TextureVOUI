//
//  RouteVC.swift
//  TextureVOUI
//
//  Created by Jefferson Setiawan on 13/09/21.
//

import UIKit

public final class RouteVC: UITableViewController {
    private enum Route: String, CaseIterable {
        case isAccessibilityFalse = "Is Accessibility False"
        case controlNode = "ASControlNode Issue"
        case tooNested = "Too Nested Case"
    }

    private let routes: [Route] = Route.allCases

    public init() {
        super.init(style: .plain)

        title = "Texture UITest Issue"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    override public func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let selectedRoute = routes[indexPath.row]
        switch selectedRoute {
        case .isAccessibilityFalse:
            navigationController?.pushViewController(IsAccessibilityElementVC(), animated: true)
        case .controlNode:
            navigationController?.pushViewController(ControlNodeVC(), animated: true)
        case .tooNested:
            navigationController?.pushViewController(TooNestedVC(), animated: true)
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
