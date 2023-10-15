//
//  ModalViewClassViewModel.swift
//  FoodDelivery
//
//  Created by Yury on 13.10.23.
//

import Foundation

// Протокол, описывающий интерфейс ViewModel для модального представления
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

// Реализация ViewModel для модального представления
class ModalViewClassViewModel: ModalViewClassViewModelProtocol {
    
    // MARK: - Properties
    var dish: Dish
    
    var onUpdateCartBadge: (() -> Void)?
    
    // Название блюда
    var dishName: String {
        return dish.name
    }
    
    // Описание блюда
    var dishDescription: String {
        return dish.description
    }
    
    // Цена блюда в формате "X ₽"
    var price: String {
        return "\(dish.price) ₽"
    }
    
    // Вес блюда
    var weight: String {
        return "· \(dish.weight)г"
    }
    
    // Данные изображения блюда
    var imageData: Data? {
        return ImageManager.shared.getCachedImageData(from: dish.imageURL)
    }
    
    // Статус "Избранное"
    var isFavorite: Bool {
        get {
            return dish.isFavorite
        }
        set {
            dish.isFavorite = newValue
        }
    }
    
    // Замыкание для обработки изменения статуса "Избранное"
    var onFavoriteStatusChanged: ((Bool) -> Void)?
    
    // MARK: - Инициализация
    init(dish: Dish) {
        self.dish = dish
    }
    
}

// MARK: - Методы
extension ModalViewClassViewModel {
    // Переключение статуса "Избранное"
    func toggleFavorite() {
        dish.isFavorite.toggle()
        onFavoriteStatusChanged?(dish.isFavorite)
    }
    
    // Добавление товара в корзину
    func addItemToCart() {
        let cartItem = CartItem(dish: self.dish, name: self.dish.name, quantity: 1, totalSum: self.dish.price)
        CartManager.shared.addItem(cartItem)
        onUpdateCartBadge?()
    }
    
}
