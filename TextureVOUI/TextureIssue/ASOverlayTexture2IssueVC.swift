//
//  ASOverlayTexture2IssueVC.swift
//  TextureVOUI
//
//  Created by jefferson.setiawan on 10/11/21.
//

import AsyncDisplayKit

internal final class ASOverlayTexture2IssueVC: ASDKViewController<ASDisplayNode> {
    private let explanationNode: ASTextNode2 = {
        let node = ASTextNode2()
        node.attributedText = .body("""
        Texture 2 have issues when using `ASOverlayLayoutSpec` with dynamic configuration for example in Variant Image on PDP.
        When you tap the toggle stock button, the Stock Empty overlay zIndex is in wrong order, the order is behind the imageNode.
        This issue not happen on Texture 3, and for workaround, we manually change the zPosition of the imageNode.
        """)
        return node
    }()
    private let variantImageNode: GlobalVariantImageNode
    private let switchButton: ASButtonNode = {
        let button = ASButtonNode()
        button.setAttributedTitle(.body("Toggle Stock Available"), for: .normal)
        return button
    }()
    internal override init() {
        let model = VariantImageModel(image: "https://cdn.eraspace.com/pub/media/catalog/product/i/p/iphone_13_pro_silver_1.jpg", isStockAvailable: true, isPromo: true)
        self.variantImageNode = GlobalVariantImageNode(model: model)
        super.init(node: ASDisplayNode())
        node.backgroundColor = .white
        node.automaticallyManagesSubnodes = true
        
        node.layoutSpecBlock = { [explanationNode, variantImageNode, switchButton] _, _ in
            
            return ASStackLayoutSpec(
                direction: .vertical,
                spacing: 16,
                justifyContent: .start,
                alignItems: .start,
                children: [explanationNode, variantImageNode, switchButton]
            )
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switchButton.addTarget(self, action: #selector(didToggleStock), forControlEvents: .touchUpInside)
    }
    
    @objc private func didToggleStock() {
        variantImageNode.toggleStock()
    }
    
    internal required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct VariantImageModel {
    var image: String
    var isStockAvailable: Bool
    var isPromo: Bool
}
internal final class GlobalVariantImageNode: ASDisplayNode {
    private let imageNode: ASNetworkImageNode = {
        let imageNode = ASNetworkImageNode()
        imageNode.style.preferredSize = CGSize(width: 50, height: 50)
        imageNode.contentMode = .scaleAspectFit
        return imageNode
    }()

    private let backgroundNode: ASDisplayNode = {
        let node = ASDisplayNode()
        node.style.preferredSize = CGSize(width: 56, height: 56)
        node.clipsToBounds = false
        return node
    }()

    private var overlayEmptyVariant: ASDisplayNode?
    // node that with grey screen
    private var textOverLay: ASTextNode?
    internal let promoNode: ASTextNode = {
        let node = ASTextNode()
        node.attributedText = .body("PROMO")
        return node
    }()
    private var model: VariantImageModel
    internal init(model: VariantImageModel) {
        self.model = model
        super.init()
        style.preferredSize = CGSize(width: 56, height: 56)

        clipsToBounds = false
        automaticallyManagesSubnodes = true
        isAccessibilityElement = true
        update(model: model)
    }

    override public func didLoad() {
        super.didLoad()
        setupUI()
        setupTapGesture()
    }

    private func update(model: VariantImageModel) {
        self.model = model
        imageNode.setURL(URL(string: model.image), resetToDefault: false)


        if model.isStockAvailable {
            setupEmptyVariant(isAvailable: true)
        } else {
            setupEmptyVariant(isAvailable: false)
            backgroundNode.view.layer.borderColor = UIColor.lightGray.cgColor
            backgroundNode.view.layer.borderWidth = 1
        }
        setNeedsLayout()
    }
    
    internal func toggleStock() {
        model.isStockAvailable.toggle()
        update(model: model)
    }

    override public func layoutSpecThatFits(_: ASSizeRange) -> ASLayoutSpec {
        if let overlay = overlayEmptyVariant {
//            imageNode.zPosition = -1
            let textCenter = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: .minimumXY, child: textOverLay ?? ASDisplayNode())
            let overlayWrapper = ASWrapperLayoutSpec(layoutElements: [overlay, textCenter])
            let centerImage = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: .minimumXY, child: imageNode)
            return ASBackgroundLayoutSpec(child: overlayWrapper, background: centerImage)
        }

//        imageNode.zPosition = 1
        if model.isPromo {
            let relativeSpec = ASRelativeLayoutSpec(
                horizontalPosition: .center,
                verticalPosition: .start,
                sizingOption: [],
                child: promoNode
            )
            // promo need to overlay over bounds
            relativeSpec.style.layoutPosition.y = -(promoNode.calculatedSize.height / 2)
            let center = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: .minimumXY, child: imageNode)
            let overlay = ASOverlayLayoutSpec(child: backgroundNode, overlay: center)
            return ASAbsoluteLayoutSpec(sizing: .sizeToFit, children: [overlay, relativeSpec])
        }
        let center = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: .minimumXY, child: imageNode)
        return ASOverlayLayoutSpec(child: backgroundNode, overlay: center)
    }

    // MARK: Function

    private func setupUI() {
        view.backgroundColor = .white
        backgroundNode.view.backgroundColor = .white
        backgroundNode.view.layer.cornerRadius = 8
        backgroundNode.view.layer.borderColor = UIColor.lightGray.cgColor
        backgroundNode.view.layer.borderWidth = 1
        imageNode.view.layer.cornerRadius = 6
        promoNode.view.layer.borderWidth = 1
        promoNode.view.layer.borderColor = UIColor.white.cgColor
    }

    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer()
        view.addGestureRecognizer(tapGesture)
        view.isUserInteractionEnabled = true
//        tapGesture.rx
//            .event
//            .mapToVoid()
//            .asDriverOnErrorJustComplete()
//            .drive(onNext: { [store] in
//                store.send(.didTap)
//            })
//            .disposed(by: rx.disposeBag)
    }

    private func updateChipUI(isSelected: Bool) {
        if isSelected {
            backgroundNode.view.layer.borderColor = UIColor.green.cgColor
            backgroundNode.view.layer.borderWidth = 2
            accessibilityTraits = .selected
            overlayEmptyVariant?.view.layer.borderWidth = 2
            overlayEmptyVariant?.view.layer.borderColor = UIColor.green.cgColor
        } else {
            backgroundNode.view.layer.borderColor = UIColor.lightGray.cgColor
            backgroundNode.view.layer.borderWidth = 1
            accessibilityTraits = .image
            overlayEmptyVariant?.view.layer.borderWidth = 0
        }
        setNeedsLayout()
    }

    internal func updateCampaignState() {
        setNeedsLayout()
    }
    
    private func setupEmptyVariant(isAvailable: Bool) {
        if isAvailable {
            overlayEmptyVariant = nil
            textOverLay = nil
        } else {
            overlayEmptyVariant = ASDisplayNode()
            overlayEmptyVariant?.style.preferredSize = CGSize(width: 48, height: 48)
            overlayEmptyVariant?.view.backgroundColor = UIColor.darkGray.withAlphaComponent(0.68)
            overlayEmptyVariant?.view.layer.cornerRadius = 8
            textOverLay = ASTextNode()
            textOverLay?.attributedText = NSAttributedString.body("Sold out", color: .white)
        }
    }

    override internal func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard let subnodes = subnodes else {
            return super.hitTest(point, with: event)
        }

        for subview in subnodes {
            if !subview.isHidden,
                subview.alpha > 0,
                subview.isUserInteractionEnabled,
                subview.point(inside: convert(point, to: subview), with: event) {
                return subview.view
            }
        }

        return super.hitTest(point, with: event)
    }
}
