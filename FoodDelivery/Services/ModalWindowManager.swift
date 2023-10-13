//
//  ModalWindowManager.swift
//  FoodDelivery
//
//  Created by Yury on 12.10.23.
//

import UIKit

class ModalWindowManager {
    
    // MARK: Properties
    
    static let shared = ModalWindowManager()
    
    // MARK: init
    
    private init() { }
    
}

// MARK: - Methods

extension ModalWindowManager {
    func presentModalWindow(from parentViewController: UIViewController, dish: Dish) -> ModalViewClass? {
        
        // Затемнение
        guard let tabBarController = parentViewController.tabBarController else { return nil }
        
        let dimmingView = UIView(frame: tabBarController.view.bounds)
        dimmingView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        dimmingView.tag = 1234 // Чтобы потом можно было легко найти и удалить
        
        tabBarController.view.addSubview(dimmingView)
        
        dimmingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dimmingView.topAnchor.constraint(equalTo: tabBarController.view.topAnchor),
            dimmingView.leftAnchor.constraint(equalTo: tabBarController.view.leftAnchor),
            dimmingView.rightAnchor.constraint(equalTo: tabBarController.view.rightAnchor),
            dimmingView.bottomAnchor.constraint(equalTo: tabBarController.view.bottomAnchor)
        ])
        
        // Отображение модального окна
        if let modalView = ModalViewClass.instantiateFromNib() {
                let viewModel = ModalViewClassViewModel(dish: dish)
                modalView.configure(with: viewModel)
            modalView.translatesAutoresizingMaskIntoConstraints = false
            tabBarController.view.addSubview(modalView)
            
            NSLayoutConstraint.activate([
                modalView.leadingAnchor.constraint(equalTo: tabBarController.view.leadingAnchor, constant: 24), // Отступ слева
                modalView.trailingAnchor.constraint(equalTo: tabBarController.view.trailingAnchor, constant: -24), // Отступ справа
                modalView.centerXAnchor.constraint(equalTo: tabBarController.view.centerXAnchor),
                modalView.centerYAnchor.constraint(equalTo: tabBarController.view.centerYAnchor)
            ])
            
            return modalView
        }
        
        return nil
    }
    
}
