//
//  NSAttributedString+Helper.swift
//  TextureVOUI
//
//  Created by Jefferson Setiawan on 16/09/21.
//

import UIKit

extension NSAttributedString {
    internal class func setFont(font: UIFont, kerning: Double = 0, color: UIColor, lineSpacing: CGFloat? = nil, alignment: NSTextAlignment, strikethrough: Bool) -> [NSAttributedString.Key: Any] {
        let paragraphStyle = NSMutableParagraphStyle()
        if let lineSpacing = lineSpacing {
            paragraphStyle.lineSpacing = lineSpacing
        }
        paragraphStyle.alignment = alignment

        var attribute = [.font: font,
                         .kern: kerning,
                         .foregroundColor: color,
                         .paragraphStyle: paragraphStyle] as [NSAttributedString.Key: Any]

        if strikethrough {
            attribute[.strikethroughStyle] = NSUnderlineStyle.single.rawValue
        }
        return attribute
    }

    internal class func title(_ string: String,
                              color: UIColor = .black,
                              isBold: Bool = false,
                              alignment: NSTextAlignment = .left,
                              strikethrough: Bool = false) -> NSAttributedString {
        let attribute = NSAttributedString.setFont(
            font: .systemFont(
                ofSize: 16,
                weight: isBold ? .bold : .regular
            ),
            kerning: -0.1,
            color: color,
            lineSpacing: 3.0,
            alignment: alignment,
            strikethrough: strikethrough
        )

        let attributeString = NSMutableAttributedString(string: string, attributes: attribute)
        return attributeString
    }

    internal class func body(_ string: String,
                             color: UIColor = .black,
                             isBold: Bool = false,
                             alignment: NSTextAlignment = .left,
                             strikethrough: Bool = false) -> NSAttributedString {
        let attribute = NSAttributedString.setFont(
            font: .systemFont(
                ofSize: 14,
                weight: isBold ? .bold : .regular
            ),
            color: color,
            lineSpacing: 4.5,
            alignment: alignment,
            strikethrough: strikethrough
        )
        let attributeString = NSMutableAttributedString(string: string, attributes: attribute)
        return attributeString
    }
}
