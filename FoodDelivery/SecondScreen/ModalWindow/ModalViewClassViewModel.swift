//
//  ModalViewClassViewModel.swift
//  FoodDelivery
//
//  Created by Yury on 13.10.23.
//

import Foundation

protocol ModalViewClassViewModelProtocol {
    var dishName: String { get }
    var dishDescription: String { get }
    var price: String { get }
    var imageData: Data? { get }
    var weight: String { get }
    var isFavorite: Bool { get set }
    func toggleFavorite()
    var onFavoriteStatusChanged: ((Bool) -> Void)? { get set }
    var dish: Dish { get }
    func addItemToCart()
    var onUpdateCartBadge: (() -> Void)? { get set }
}

class ModalViewClassViewModel: ModalViewClassViewModelProtocol {
    
    // MARK: - Properties
    
    var dish: Dish
    
    var onUpdateCartBadge: (() -> Void)?
    
    var dishName: String {
        return dish.name
    }
    
    var dishDescription: String {
        return dish.description
    }
    
    var price: String {
        return "\(dish.price) ₽"
    }
    
    var weight: String {
        return "· \(dish.weight)г"
    }
    
    var imageData: Data? {
            return ImageManager.shared.getCachedImageData(from: dish.imageURL)
        }
    
    var isFavorite: Bool {
            get {
                return dish.isFavorite
            }
            set {
                dish.isFavorite = newValue
            }
        }
    
    var onFavoriteStatusChanged: ((Bool) -> Void)?
    
    init(dish: Dish) {
        self.dish = dish
    }
    
}

// MARK: Methods

extension ModalViewClassViewModel {
    func toggleFavorite() {
        dish.isFavorite.toggle()
        onFavoriteStatusChanged?(dish.isFavorite)
    }
    
    func addItemToCart() {
        let cartItem = CartItem(dish: self.dish, name: self.dish.name, quantity: 1, totalSum: self.dish.price)
            CartManager.shared.addItem(cartItem)
            onUpdateCartBadge?()
        }
    
}
