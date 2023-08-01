//
//  ListSection.swift
//  TextureVOUI
//
//  Created by andhika.setiadi on 01/08/23.
//

import Foundation

enum ListSection {
    case addressWidget(String)
    case promoWidget([String])
    case categoryWidget([Category])
    case productCardWidget([Product])
    
    var count: Int {
        switch self {
        case .addressWidget:
            return 1
        case .promoWidget(let images):
            return images.count
        case .categoryWidget(let categories):
            return categories.count
        case .productCardWidget(let products):
            return products.count
        }
    }
    
    var title: String {
        switch self {
        case .addressWidget:
            return "Address Widget"
        case .promoWidget:
            return "Promo Widget"
        case .categoryWidget:
            return "Category Widget"
        case .productCardWidget:
            return "Product Card Widget"
        }
    }
}
