//
//  TabBarBadgeManager.swift
//  FoodDelivery
//
//  Created by Yury on 13.10.23.
//

import UIKit

class TabBarBadgeManager {
    
    // MARK: - Propertis
    private weak var tabBarController: UITabBarController?
    
    // MARK: - init
    init(tabBarController: UITabBarController?) {
        self.tabBarController = tabBarController
    }
    
}

// MARK: - Methods
extension TabBarBadgeManager {
    func updateCartBadge(with itemCount: Int) {
        let cartTabIndex = 2
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
