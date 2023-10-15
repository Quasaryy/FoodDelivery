//
//  CustomStepper.swift
//  FoodDelivery
//
//  Created by Yury on 14.10.23.
//

import UIKit

// Создаем кастомный степпер
class CustomStepper: UIStepper {
    
    // MARK: Properties
    private var customLabel: UILabel!
    private let defaultFontName = "SFProDisplay-Medium"
    private let defaultFontSize: CGFloat = 14
    
    // Переопределяем значение, чтобы обновлять текст в лейбле при изменении
    override var value: Double {
        didSet {
            customLabel.text = "\(Int(value))"
        }
    }
    
    // MARK: - init
    // Инициализатор для создания степпера из Interface Builder
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
}

// MARK: - Methods
extension CustomStepper {
    // Настройка внешнего вида и лейбла степпера
    private func setup() {
        customLabel = UILabel()
        customLabel.textAlignment = .center
        customLabel.font = UIFont(name: defaultFontName, size: defaultFontSize)
        customLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(customLabel)
        
        customLabel.text = "\(Int(value))"
        
        setIncrementImage(UIImage(named: "StepperPlus"), for: .normal)
        setDecrementImage(UIImage(named: "StepperMinis"), for: .normal)
        
        addTarget(self, action: #selector(valueChanged), for: .valueChanged)
        
        setupConstraints()
    }
    
    // Настройка констрейнтов для лейбла
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            customLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            customLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    // Обработчик события изменения значения степпера
    @objc
    private func valueChanged() {
        customLabel.text = "\(Int(value))"
    }
    
}
