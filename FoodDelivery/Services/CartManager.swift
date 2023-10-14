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
    func removeItem(_ item: CartItem) {
        if let index = items.firstIndex(where: { $0.dish.id == item.dish.id }) {
            items.remove(at: index)
        }
    }
    
    // Метод для получения общего количества элементов в корзине
    func totalItemsCount() -> Int {
        return items.reduce(0) { $0 + $1.quantity }
    }
}
