//
//  SecondCollectionViewCellViewModel.swift
//  FoodDelivery
//
//  Created by Yury on 10.10.23.
//

import Foundation

protocol SecondHorizontalCollectionViewCellViewModelProtocol {
    var tagName: String { get }
}

class SecondHorizontalCollectionViewCellViewModel: SecondHorizontalCollectionViewCellViewModelProtocol {
    
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
