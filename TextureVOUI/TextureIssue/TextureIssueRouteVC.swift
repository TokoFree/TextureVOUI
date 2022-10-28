//
//  TextureIssueRouteVC.swift
//  TextureVOUI
//
//  Created by Jefferson Setiawan on 17/09/21.
//

import UIKit

public final class TextureIssueRouteVC: UITableViewController {
    private enum Route: String, CaseIterable {
        case setNeedsLayoutChildIssue = "Parent setNeedsLayout issue"
        case setNeedsLayoutChildSuccess = "Parent setNeedsLayout non issue in Unify"
        case safeAreaIssue = "ChildNode doesn't have the same safeArea as parent"
        case collectionNodeCell = "CollectionNode deinit cell on reload"
        case tableNodeCell = "ASTableNode deinit cell on reload"
        case animateLayoutTransitionIssue = "Animate Layout Transition is not called when node not visible"
        case parentWrapperSetNeedsLayoutIssue = "Parent node with ASWrapperLayout does not auto setNeedsLayout after setNeedsLayout children"
        case overlayTexture2Problem = "ASOverlaySpec Depth Issue on Texture 2"
        case ancestorInCollectionNode = "Can't Convert between ASCollectionNode and ASCellNode"
        case nodeCreationOnLayout = "Node Creation on layout phase"
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
        case .setNeedsLayoutChildIssue:
            navigationController?.pushViewController(ParentNodeSetNeedsLayoutVC(), animated: true)
        case .setNeedsLayoutChildSuccess:
            navigationController?.pushViewController(ParentNodeSuccessSetNeedsLayoutVC(), animated: true)
        case .safeAreaIssue:
            navigationController?.pushViewController(SafeAreaIssueVC(), animated: true)
        case .collectionNodeCell:
            navigationController?.pushViewController(ASCollectionDeinitCellVC(), animated: true)
        case .tableNodeCell:
            navigationController?.pushViewController(ASTableDeinitCellVC(), animated: true)
        case .animateLayoutTransitionIssue:
            navigationController?.pushViewController(AnimateLayoutTransitionNotCalledVC(), animated: true)
        case .parentWrapperSetNeedsLayoutIssue:
            navigationController?.pushViewController(ParentWithWrapperDoesNotAutoSetNeedsLayoutVC(), animated: true)
        case .overlayTexture2Problem:
            navigationController?.pushViewController(ASOverlayTexture2IssueVC(), animated: true)
        case .ancestorInCollectionNode:
            navigationController?.pushViewController(DemoScrollHorizontalVC(), animated: true)
        case .nodeCreationOnLayout:
            navigationController?.pushViewController(NodeCreationInsideLayoutVC(), animated: true)
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
