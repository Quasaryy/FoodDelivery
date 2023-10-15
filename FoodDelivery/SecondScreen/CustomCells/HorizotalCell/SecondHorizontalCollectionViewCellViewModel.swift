//
//  SecondCollectionViewCellViewModel.swift
//  FoodDelivery
//
//  Created by Yury on 10.10.23.
//

import Foundation

class SecondHorizontalCollectionViewCellViewModel {
    
    // MARK: - Propertis
    let tag: Teg
    
    var tagName: String {
        return tag.rawValue
    }
    
    // MARK: - init
    init(tag: Teg) {
        self.tag = tag
    }
    
}
