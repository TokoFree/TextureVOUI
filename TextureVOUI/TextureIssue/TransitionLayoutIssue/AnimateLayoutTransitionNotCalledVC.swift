//
//  AnimateLayoutTransitionNotCalledVC.swift
//  TextureVOUI
//
//  Created by Adriani Zenitha on 07/10/21.
//

import AsyncDisplayKit
import Foundation

/*
    Issue: `animateLayoutTransition` function won't be called if the node size is still zero, see `ASDisplayNode+Layout.mm` line 556.
    Case: One of the examples where this issue could happen,
            - let's say you have a Tab with 2 items, and in the second Tab you have an ASDisplayNode A,
            - while doing action in the first Tab, you update the A node in the second Tab,
            - since the A node is not loaded and has no size yet, if you're using `transitionLayout` with custom aimation to relayout A node, the `animateLayoutTransition` function won't be called.
    Solution: Don't depend on `animateLayoutTransition` function except you need to use its context, and unless you are sure that the node is already loaded and has size (you could make sure by adding extra check using `isNodeLoaded` or `isVisible`, for example).
 */

public final class AnimateLayoutTransitionNotCalledVC: ASDKViewController<ASDisplayNode> {
    private let redAnimatedNode: AnimatedNode = AnimatedNode()

    public override init() {
        super.init(node: ASDisplayNode())

        print(">>>> change color on init")
        redAnimatedNode.bgColor = UIColor.green

        node.automaticallyManagesSubnodes = true
        node.backgroundColor = UIColor.white
        node.layoutSpecBlock = { [weak self] _, _ in
            guard let self = self else { return ASLayoutSpec() }
            return ASStackLayoutSpec(direction: .vertical, spacing: 0, justifyContent: .start, alignItems: .start, children: [self.redAnimatedNode])
        }
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Uncomment to change color, since node is ready, the `animateLayoutTransition` function will be called
//    public override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        print(">>>> viewDidAppear")
//        redAnimatedNode.bgColor = UIColor.blue
//    }
}

public final class AnimatedNode: ASDisplayNode {
    public var bgColor: UIColor = .red {
        didSet {
            print(">>>> didSet bgColor")
            transitionLayout(withAnimation: true, shouldMeasureAsync: false)
        }
    }

    public override init() {
        super.init()

        backgroundColor = bgColor
        style.width = ASDimensionMake(100)
        style.height = ASDimensionMake(100)
    }

    public override func animateLayoutTransition(_ context: ASContextTransitioning) {
        print(">>>> animateLayoutTransition")
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            guard let self = self else { return }
            self.backgroundColor = self.bgColor
        })
    }
}
