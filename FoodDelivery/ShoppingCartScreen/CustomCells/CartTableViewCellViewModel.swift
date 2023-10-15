//
//  CartTableViewCellViewModel.swift
//  FoodDelivery
//
//  Created by Yury on 14.10.23.
//

import UIKit

class CartTableViewCellViewModel {
    
    // MARK: - Properties
    var item: CartItem // Элемент корзины
    
    var name: String {
        return item.dish.name // Название продукта
    }
    
    var priceAndWeight: String {
        return "\(item.dish.price) ₽ ‧ \(item.dish.weight)г" // Цена и вес продукта
    }
    
    var imageURL: String {
        return item.dish.imageURL // URL изображения продукта
    }
    
    var quantity: Double {
        return Double(item.quantity) // Количество продукта
    }
    
    // MARK: - init
    init(item: CartItem) {
        self.item = item
    }
    
}
