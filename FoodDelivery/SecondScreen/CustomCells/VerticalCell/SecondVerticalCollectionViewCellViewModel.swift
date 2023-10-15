//
//  SecondVerticalCollectionViewCellViewModel.swift
//  FoodDelivery
//
//  Created by Yury on 11.10.23.
//

import Foundation

// Протокол для ViewModel вертикальной ячейки коллекции
protocol SecondVerticalCollectionViewCellViewModelProtocol {
    var dishName: String { get } // Название блюда
    var dishImageUrl: String { get } // URL изображения блюда
}

class SecondVerticalCollectionViewCellViewModel: SecondVerticalCollectionViewCellViewModelProtocol {
    
    // MARK: - Properties
    let dish: Dish
    
    // Названия блюда
    var dishName: String {
        return dish.name
    }
    
    // URL изображения блюда
    var dishImageUrl: String {
        return dish.imageURL
    }
    
    // MARK: - init
    init(dish: Dish) {
        self.dish = dish
    }
    
}
