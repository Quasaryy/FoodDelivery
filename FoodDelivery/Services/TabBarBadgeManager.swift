//
//  TabBarBadgeManager.swift
//  FoodDelivery
//
//  Created by Yury on 13.10.23.
//

import UIKit

// Протокол для управления бейджами на таб-баре
protocol TabBarBadgeManaging {
    func updateCartBadge(with itemCount: Int)
}

// Класс для управления бейджами на таб-баре
class TabBarBadgeManager {
    
    // MARK: - Properties
    private weak var tabBarController: UITabBarController?
    
    // MARK: - Init
    init(tabBarController: UITabBarController?) {
        self.tabBarController = tabBarController
    }
    
}

// MARK: - Methods
extension TabBarBadgeManager {
    // Метод для обновления бейджа корзины на таб-баре
    func updateCartBadge(with itemCount: Int) {
        let cartTabIndex = 2 // Индекс вкладки с корзиной
        if let cartTab = tabBarController?.tabBar.items?[cartTabIndex] {
            // Если корзина пуста, скрываем бейдж
            if itemCount == 0 {
                cartTab.badgeValue = nil
            } else {
                cartTab.badgeValue = "\(itemCount)"
            }
        }
    }
    
}
