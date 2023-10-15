//
//  CartTableViewCellViewModel.swift
//  FoodDelivery
//
//  Created by Yury on 14.10.23.
//

import UIKit

class CartTableViewCellViewModel {
    var item: CartItem
    
    init(item: CartItem) {
        self.item = item
    }
    
    var name: String {
        return item.dish.name
    }
    
    var priceAndWeight: String {
        return "\(item.dish.price) ₽ ‧ \(item.dish.weight)г"
    }
    
    var imageURL: String {
        return item.dish.imageURL
    }
    
    var quantity: Double {
        return Double(item.quantity)
    }
}

