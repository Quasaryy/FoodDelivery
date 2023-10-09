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
        alwaysWhiteTabBar()
        adjustTabBarItemsPosition()
        chnageBorderColor()
    }
    
    // MARK: - viewDidLayoutSubviews
    
    override func viewDidLayoutSubviews() {
        changeHieghtTabBar()
    }
    
}

// MARK: - Methods

extension CustomTabBarController {
    private func alwaysWhiteTabBar() {
        tabBar.backgroundColor = .white
        tabBar.isTranslucent = false
    }
    
    private func adjustTabBarItemsPosition() {
        let yOffset: CGFloat = 3 // корректировка вертикального положения иконки
        for item in tabBar.items! {
            item.imageInsets = UIEdgeInsets(top: yOffset, left: 0, bottom: -yOffset, right: 0)
        }
    }
    
    private func imageWithColor(color: UIColor, size: CGSize) -> UIImage? {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    private func chnageBorderColor() {
        tabBar.backgroundImage = UIImage()
        if let borderColorImage = imageWithColor(color: UIColor(red: 232/255, green: 233/255, blue: 236/255, alpha: 1), size: CGSize(width: tabBar.bounds.width, height: 1)) {
            tabBar.shadowImage = borderColorImage
        }
    }
    
    private func changeHieghtTabBar() {
        var newFrame = tabBar.frame
        let newHeight: CGFloat = 88 // высота ТабБара
        newFrame.size.height = newHeight
        newFrame.origin.y = view.frame.size.height - newHeight
        tabBar.frame = newFrame
    }
    
}
