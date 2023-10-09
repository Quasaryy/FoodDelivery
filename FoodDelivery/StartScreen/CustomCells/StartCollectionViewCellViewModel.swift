//
//  StartCollectionViewCellViewModel.swift
//  FoodDelivery
//
//  Created by Yury on 10.10.23.
//

import Foundation

class StartCollectionViewCellViewModel {
    let category: Сategory
    
    init(category: Сategory) {
        self.category = category
    }
    
    var categoryName: String {
        return category.name
    }
    
    var imageURL: URL? {
        return URL(string: category.imageURL)
    }
    
}
