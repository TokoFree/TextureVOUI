//
//  Array+Helper.swift
//  TextureVOUI
//
//  Created by andhika.setiadi on 01/08/23.
//

import Foundation

extension Array {
    @inlinable
    public subscript(safe index: Index) -> Element? {
        get {
            guard startIndex <= index, index < endIndex else { return nil }

            return self[index]
        }
        set {
            guard
                let newValue = newValue,
                startIndex <= index, index < endIndex
            else {
                return
            }

            self[index] = newValue
        }
    }
}

