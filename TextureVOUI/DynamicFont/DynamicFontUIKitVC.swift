//
//  DynamicFontUIKitVC.swift
//  TextureVOUI
//
//  Created by jefferson.setiawan on 15/03/22.
//

import UIKit

internal final class DynamicFontUIKitVC: UIViewController {
    
    private let label = UILabel.createDynamicSize()
    private let attributedLabel = UILabel.createDynamicSize()
    private let customFontLabel = UILabel.createDynamicSize()
    private let customFontAttributedLabel = UILabel.createDynamicSize()
    
    // async displaykit v2 and v3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        label.font = .preferredFont(forTextStyle: UIFont.TextStyle.title1)
        label.text = "This is a headline text using .text"
        
        let attr = NSAttributedString.setFont(font: UIFont.preferredFont(forTextStyle: .title1), color: .black, alignment: .left, strikethrough: false)
        attributedLabel.attributedText = NSMutableAttributedString(string: "This is attributed text", attributes: attr)
        
        let customFont = UIFontMetrics(forTextStyle: .headline).scaledFont(for: .nunito(size: 16))
        customFontLabel.font = customFont
        customFontLabel.text = "This is custom font"
        
        let customFontAttr = NSAttributedString.setFont(font: customFont, color: .black, alignment: .left, strikethrough: false)
        customFontAttributedLabel.attributedText = NSMutableAttributedString(string: "This is attributed custom font", attributes: customFontAttr)
    
        
        let vStack = UIStackView()
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.axis = .vertical
        vStack.spacing = 16
        vStack.addArrangedSubview(label)
        vStack.addArrangedSubview(attributedLabel)
        vStack.addArrangedSubview(customFontLabel)
        vStack.addArrangedSubview(customFontAttributedLabel)
        
        view.addSubview(vStack)
        NSLayoutConstraint.activate([
            vStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            vStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            vStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            vStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}

extension UILabel {
    static func createDynamicSize() -> UILabel {
        let label = UILabel()
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = true
        label.numberOfLines = 0
        return label
    }
}
