//
//  ComponentTooDeepUIKitVC.swift
//  TextureVOUI
//
//  Created by jefferson.setiawan on 15/06/23.
//

import UIKit

internal final class ComponentTooDeepUIKitVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        /// Code to recursivly add the dummyNode to `DummyNodeThatHasAnotherNode` that is 10 hierarchy deep
        let maxDeep = 55
        let label = UILabel()
        label.text = "Title Text"
        label.accessibilityIdentifier = "textIdentifier"
        let aNode = (0...maxDeep).reversed().reduce(label, { partialResult, index -> UIView in
            DummyViewThatHasAnotherView(childView: partialResult, index: index)
        })
        aNode.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(aNode)
        NSLayoutConstraint.activate([
            aNode.topAnchor.constraint(equalTo: view.topAnchor),
            aNode.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            aNode.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 2),
            aNode.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -2),
        ])
    }
}

internal final class DummyViewThatHasAnotherView: UIView {
    private let randomColors = [UIColor.red, .blue, .yellow, .black, .cyan, .magenta]
    private let childView: UIView
    internal init(childView: UIView, index: Int) {
        self.childView = childView
        super.init(frame: .zero)
        self.accessibilityIdentifier = "component-\(index)"
        self.backgroundColor = randomColors.randomElement()!
        addSubview(childView)
        childView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            childView.topAnchor.constraint(equalTo: self.topAnchor, constant: 2),
            childView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2),
            childView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            childView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    
    internal required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
