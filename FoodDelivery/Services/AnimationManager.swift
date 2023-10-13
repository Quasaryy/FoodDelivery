//
//  AnimationManager.swift
//  FoodDelivery
//
//  Created by Yury on 13.10.23.
//

import UIKit

class AnimationManager {
    
    // MARK: - Properties
    
    static let shared = AnimationManager()
    
    // MARK: - init
    
    private init() { }
    
}

// MARK: - Methods

extension AnimationManager {
    func animateModalViewDisappearance(_ modalView: UIView, completionActions: @escaping () -> Void) {
        UIView.animate(withDuration: 0.2, animations: {
            modalView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            modalView.alpha = 0.0
        }) { _ in
            // Возвращаем modalView к его исходному состоянию
            modalView.transform = .identity
            modalView.alpha = 1.0
            completionActions()
        }
    }
    
    func animateModalViewAppearance(for view: UIView, withDuration duration: TimeInterval = 0.1) {
        view.alpha = 0.0
        view.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        UIView.animate(withDuration: duration, animations: {
            view.alpha = 1.0
            view.transform = .identity
        })
    }
    
}
