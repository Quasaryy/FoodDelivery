//
//  CustomTabBarController.swift
//  FoodDelivery
//
//  Created by Yury on 09.10.23.
//

import UIKit

// Протокол для настройки таб-бара
protocol CustomizableTabBar {
    func alwaysWhiteTabBar()
    func adjustTabBarItemsPosition()
    func addBorderToTabBar()
    func changeHeightTabBar()
}

// Константы для CustomTabBarController
private enum Constants {
    static let tabBarBackgroundColor: UIColor = .white
    static let tabBarHeight: CGFloat = 88
    static let yOffset: CGFloat = 3
    static let borderTopColor: UIColor = UIColor(red: 232/255, green: 233/255, blue: 236/255, alpha: 1)
    static let borderTopHeight: CGFloat = 1
}

class CustomTabBarController: UITabBarController {
    
    // MARK: - Properties
    private let tabBarViewModel = CustomTabBarControllerViewModel()
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        alwaysWhiteTabBar()
        adjustTabBarItemsPosition()
        addBorderToTabBar()
    }
    
    // MARK: - viewDidLayoutSubviews
    override func viewDidLayoutSubviews() {
        changeHieghtTabBar()
    }
    
}

// MARK: - Methods
extension CustomTabBarController {
    
    // Устанавливает таб-бар всегда белого цвета
    private func alwaysWhiteTabBar() {
        tabBar.backgroundColor = Constants.tabBarBackgroundColor
        tabBar.isTranslucent = false
    }
    
    // Позиционирует элементы таб-бара
    private func adjustTabBarItemsPosition() {
        guard let tabBarItems = tabBar.items else { return }
        for item in tabBarItems {
            item.imageInsets = UIEdgeInsets(top: Constants.yOffset, left: 0, bottom: -Constants.yOffset, right: 0)
        }
    }
    
    // Добавляет верхнюю границу таб-бару
    private func addBorderToTabBar() {
        let borderView = UIView(frame: CGRect(x: 0, y: 0, width: tabBar.bounds.width, height: Constants.borderTopHeight))
        borderView.backgroundColor = Constants.borderTopColor
        tabBar.addSubview(borderView)
    }
    
    // Изменяет высоту таб-бара
    private func changeHieghtTabBar() {
        var newFrame = tabBar.frame
        newFrame.size.height = tabBarViewModel.calculateTabBarHeight()
        newFrame.origin.y = view.frame.size.height - newFrame.size.height
        tabBar.frame = newFrame
    }
    
}
