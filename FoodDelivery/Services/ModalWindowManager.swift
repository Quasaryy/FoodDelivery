//
//  ModalWindowManager.swift
//  FoodDelivery
//
//  Created by Yury on 12.10.23.
//

import UIKit

protocol ModalWindowManaging {
    func presentModalWindow(from parentViewController: UIViewController, dish: Dish) -> ModalViewClass?
}

class ModalWindowManager {
    
    // MARK: Properties
    static let shared = ModalWindowManager()
    
    // MARK: init
    private init() { }
    
}

// MARK: - Methods
extension ModalWindowManager {
    func presentModalWindow(from parentViewController: UIViewController, dish: Dish) -> ModalViewClass? {
        
        // MARK: Затемнение
        
        // Проверяем, есть ли у родительского контроллера таб-бар
        guard let tabBarController = parentViewController.tabBarController else { return nil }
        
        // Создаем вью для затемнения
        let dimmingView = UIView(frame: tabBarController.view.bounds)
        dimmingView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        dimmingView.tag = 1234 // Тег для идентификации
        
        // Добавляем вью для затемнения на таб-бар
        tabBarController.view.addSubview(dimmingView)
        
        dimmingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dimmingView.topAnchor.constraint(equalTo: tabBarController.view.topAnchor),
            dimmingView.leftAnchor.constraint(equalTo: tabBarController.view.leftAnchor),
            dimmingView.rightAnchor.constraint(equalTo: tabBarController.view.rightAnchor),
            dimmingView.bottomAnchor.constraint(equalTo: tabBarController.view.bottomAnchor)
        ])
        
        // MARK: Отображение модального окна
        
        // Попытка создать модальное окно из Nib
        if let modalView = ModalViewClass.instantiateFromNib() {
            let viewModel = ModalViewClassViewModel(dish: dish)
            modalView.configure(with: viewModel)
            modalView.translatesAutoresizingMaskIntoConstraints = false
            modalView.alpha = 0.0
            modalView.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
            tabBarController.view.addSubview(modalView)
            NSLayoutConstraint.activate([
                modalView.leadingAnchor.constraint(equalTo: tabBarController.view.leadingAnchor, constant: 24),
                modalView.trailingAnchor.constraint(equalTo: tabBarController.view.trailingAnchor, constant: -24),
                modalView.centerXAnchor.constraint(equalTo: tabBarController.view.centerXAnchor),
                modalView.centerYAnchor.constraint(equalTo: tabBarController.view.centerYAnchor)
            ])
            
            // Анимация появления модального окна
            AnimationManager.shared.animateModalViewAppearance(for: modalView)
            return modalView
        }
        return nil
    }
    
}
