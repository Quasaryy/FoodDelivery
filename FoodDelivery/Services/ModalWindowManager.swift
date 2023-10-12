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
    func presentModalWindow(from parentViewController: UIViewController) {
        
        // Затемнение
        guard let tabBarController = parentViewController.tabBarController else { return }
        
        let dimmingView = UIView(frame: tabBarController.view.bounds)
        dimmingView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
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
            modalView.translatesAutoresizingMaskIntoConstraints = false
            tabBarController.view.addSubview(modalView)
            
            NSLayoutConstraint.activate([
                modalView.widthAnchor.constraint(equalToConstant: 300),
                modalView.heightAnchor.constraint(equalToConstant: 400),
                modalView.centerXAnchor.constraint(equalTo: tabBarController.view.centerXAnchor),
                modalView.centerYAnchor.constraint(equalTo: tabBarController.view.centerYAnchor)
            ])
        }
    }
    
}
