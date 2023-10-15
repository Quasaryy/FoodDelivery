//
//  CartViewControllerViewModel.swift
//  FoodDelivery
//
//  Created by Yury on 14.10.23.
//

// Протокол для ViewModel корзины
protocol CartViewControllerViewModelProtocol {
    var numberOfItems: Int { get } // Количество элементов в корзине
    func item(at index: Int) -> CartItem? // Получение элемента корзины по индексу
    func totalItemsCount() -> Int // Общее количество товаров в корзине
}

class CartViewControllerViewModel: CartViewControllerViewModelProtocol {
    
    // MARK: - Properties
    private let cartManager = CartManager.shared // Менеджер корзины
    
    // Количество элементов в корзине
    var numberOfItems: Int {
        return cartManager.items.count
    }
    
}

// MARK: - Methods
extension CartViewControllerViewModel {
    // Получение элемента корзины по индексу
    func item(at index: Int) -> CartItem? {
        return cartManager.items.indices.contains(index) ? cartManager.items[index] : nil
    }
    
    // Получение общего количества товаров в корзине
    func totalItemsCount() -> Int {
        return cartManager.totalItemsCount()
    }
    
}
