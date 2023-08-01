//
//  MockData.swift
//  TextureVOUI
//
//  Created by andhika.setiadi on 01/08/23.
//

import Foundation

internal struct MockData {
    static let shared = MockData()
    
    private let addressWidget: ListSection = {
        .addressWidget("Gedebade 1, Bandung, Jawa Barat")
    }()
    
    private let promoWidget: ListSection = {
        .promoWidget(["1", "3"])
    }()
    
    private let categoryWidget: ListSection = {
        .categoryWidget(
            [
                Category(title: "Anjing Lari", image: "8"),
                Category(title: "Anjing Happy", image: "9"),
                Category(title: "Anjing Karismatik", image: "10"),
                Category(title: "Anjing Serem", image: "11")
            ]
        )
    }()
    
    private let productCardWidget: ListSection = {
        .productCardWidget(
            [
                Product(image: "6", price: "Rp. 1000", title: "Anjing Galau", weight: "1 Kg"),
                Product(image: "7", price: "Rp. 7000", title: "Anjing Gagah", weight: "5 Kg"),
                Product(image: "2", price: "Rp. 4000", title: "Anjing Ucul", weight: "3 Kg"),
                Product(image: "4", price: "Rp. 3000", title: "Anjing Gaya", weight: "4 Kg"),
                Product(image: "5", price: "Rp. 2000", title: "Anjing Males", weight: "5 Kg")
            ]
        )
    }()
    
    internal var pageData: [ListSection] {
        [addressWidget, promoWidget, categoryWidget, productCardWidget]
    }
}
