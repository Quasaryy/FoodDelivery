//
//  SecondVerticalCollectionViewCellViewModel.swift
//  FoodDelivery
//
//  Created by Yury on 11.10.23.
//

import Foundation

class SecondVerticalCollectionViewCellViewModel {
    let dish: Dish
    
    init(dish: Dish) {
        self.dish = dish
    }
    
    var dishName: String {
        return dish.name
    }
    
    var dishImageUrl: String {
        return dish.imageURL
    }
    
}
