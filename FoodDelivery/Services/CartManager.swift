//
//  CartManager.swift
//  FoodDelivery
//
//  Created by Yury on 13.10.23.
//

import Foundation

class CartManager {
    
    // MARK: - Properties
    
    static let shared = CartManager() // Создаем singleton
    var items: [CartItem] = [] // Массив элементов корзины
    
}

// MARK: - Methods
extension CartManager {
    // Метод для добавления элемента в корзину
    func addItem(_ item: CartItem) {
        if let index = items.firstIndex(where: { $0.dish.id == item.dish.id }) {
            // Если продукт уже есть в корзине, увеличиваем его количество
            items[index].quantity += item.quantity
            items[index].totalSum += item.totalSum
        } else {
            // Иначе добавляем новый элемент
            items.append(item)
        }
    }
    
    // Метод для удаления элемента из корзины
    func removeItem(at index: Int) {
        if index >= 0 && index < items.count {
            items.remove(at: index)
        }
    }
    
    // Метод для получения общего количества элементов в корзине
    func totalItemsCount() -> Int {
        return items.reduce(0) { $0 + $1.quantity }
    }
    
    // Метод для вычисления общей стоимости товаров в корзине
    func totalCartValue() -> Int {
        return items.reduce(0) { $0 + $1.totalSum }
    }
    
    // Метод для обновления количества товара
    func updateQuantity(for dish: Dish, to newQuantity: Int) {
        if let index = items.firstIndex(where: { $0.dish.id == dish.id }) {
            // Устанавливаем новое количество
            items[index].quantity = newQuantity
            
            // Пересчитываем общую стоимость товара
            items[index].totalSum = newQuantity * dish.price
        }
    }
    
    func clearCart() {
        items.removeAll()
    }
    
}
