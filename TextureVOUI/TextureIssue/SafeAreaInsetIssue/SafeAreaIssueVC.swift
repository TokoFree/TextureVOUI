//
//  SafeAreaIssueVC.swift
//  TextureVOUI
//
//  Created by Jefferson Setiawan on 22/09/21.
//

import AsyncDisplayKit

class SafeAreaIssueVC: ASDKViewController<ASDisplayNode> {
    private var rootNode: ASDisplayNode = NodeA()
    override init() {
        super.init(node: ASDisplayNode())
        node.automaticallyManagesSubnodes = true
        node.automaticallyRelayoutOnSafeAreaChanges = true
        node.layoutSpecBlock = { [weak self] _, _ in
            guard let self = self else { return ASLayoutSpec() }
            return ASWrapperLayoutSpec(layoutElement: self.rootNode)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // simulate change the node after 2 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.rootNode = NodeB()
            self.node.setNeedsLayout()
        }
    }
}
// Node
class NodeA: ASDisplayNode {
    private let button = ASButtonNode()

    override init() {
        super.init()
        automaticallyManagesSubnodes = true
        automaticallyRelayoutOnSafeAreaChanges = true
        button.setAttributedTitle(NSAttributedString(string: "HELLO WORLD FROM NODE A!"), for: .normal)
        button.backgroundColor = .yellow
        backgroundColor = .red
    }

    override func layoutSpecThatFits(_: ASSizeRange) -> ASLayoutSpec {
        let relative = ASRelativeLayoutSpec(horizontalPosition: .center, verticalPosition: .end, sizingOption: .minimumSize, child: button)
        return ASInsetLayoutSpec(insets: .init(top: 0, left: 0, bottom: safeAreaInsets.bottom, right: 0), child: relative)
    }
}

class NodeB: ASDisplayNode {
    private let button = ASButtonNode()

    override init() {
        super.init()
        automaticallyManagesSubnodes = true
        automaticallyRelayoutOnSafeAreaChanges = true
        button.setAttributedTitle(NSAttributedString(string: "HELLO WORLD FROM NODE B!"), for: .normal)
        button.backgroundColor = .lightGray
        backgroundColor = .green
    }

    override func layoutSpecThatFits(_: ASSizeRange) -> ASLayoutSpec {
        print("<<< NodeB safeAreaInsets: ", safeAreaInsets.bottom)
        let relative = ASRelativeLayoutSpec(horizontalPosition: .center, verticalPosition: .end, sizingOption: .minimumSize, child: button)
        return ASInsetLayoutSpec(insets: .init(top: 0, left: 0, bottom: safeAreaInsets.bottom, right: 0), child: relative)
    }
}
