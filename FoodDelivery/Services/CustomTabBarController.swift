//
//  CustomTabBarController.swift
//  FoodDelivery
//
//  Created by Yury on 09.10.23.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTopBorderToTabBar()
    }
    
}

// MARK: - Methods

extension CustomTabBarController {
    func addTopBorderToTabBar() {
        let borderHeight: CGFloat = 1.0 // Высота бордера
        let yOffset: CGFloat = -10 // Отступ от верха иконки на UITabBar
        
        let borderView = UIView(frame: CGRect(x: 0, y: yOffset, width: tabBar.bounds.width, height: borderHeight))
        borderView.backgroundColor = UIColor(red: 232/255, green: 233/255, blue: 236/255, alpha: 1) // Цвет бордера
        tabBar.addSubview(borderView)
        tabBar.sendSubviewToBack(borderView)
    }
    
}
