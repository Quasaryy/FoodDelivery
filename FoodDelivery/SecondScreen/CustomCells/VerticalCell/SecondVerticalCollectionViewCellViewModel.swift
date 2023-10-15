//
//  SecondVerticalCollectionViewCellViewModel.swift
//  FoodDelivery
//
//  Created by Yury on 11.10.23.
//

import Foundation

protocol SecondVerticalCollectionViewCellViewModelProtocol {
    var dishName: String { get }
    var dishImageUrl: String { get }
}

class SecondVerticalCollectionViewCellViewModel: SecondVerticalCollectionViewCellViewModelProtocol  {
    
    // MARK: - Properties
    let dish: Dish
    
    var dishName: String {
        return dish.name
    }
    
    var dishImageUrl: String {
        return dish.imageURL
    }
    
    // MARK: - init
    init(dish: Dish) {
        self.dish = dish
    }
    
}
