//
//  SecondCollectionViewCellViewModel.swift
//  FoodDelivery
//
//  Created by Yury on 10.10.23.
//

import Foundation

class SecondHorizontalCollectionViewCellViewModel {
    let tag: Teg
    
    init(tag: Teg) {
        self.tag = tag
    }
    
    var tagName: String {
        return tag.rawValue
    }
    
}
