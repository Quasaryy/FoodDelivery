//
//  CartViewControllerViewModel.swift
//  FoodDelivery
//
//  Created by Yury on 14.10.23.
//

protocol CartViewControllerViewModelProtocol {
    var numberOfItems: Int { get }
    func item(at index: Int) -> CartItem?
    func totalItemsCount() -> Int
}

class CartViewControllerViewModel: CartViewControllerViewModelProtocol {
    
    private let cartManager = CartManager.shared
    
    var numberOfItems: Int {
        return cartManager.items.count
    }
    
    func item(at index: Int) -> CartItem? {
        return cartManager.items.indices.contains(index) ? cartManager.items[index] : nil
    }
    
    func totalItemsCount() -> Int {
        return cartManager.totalItemsCount()
    }

}

