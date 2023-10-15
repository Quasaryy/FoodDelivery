//
//  CustomStepper.swift
//  FoodDelivery
//
//  Created by Yury on 14.10.23.
//

import UIKit

class CustomStepper: UIStepper {
    
    // MARK: Properties
    private var customLabel: UILabel!
    private let defaultFontName = "SFProDisplay-Medium"
    private let defaultFontSize: CGFloat = 14
    
    override var value: Double {
        didSet {
            customLabel.text = "\(Int(value))"
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    // MARK: - init
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
}

// MARK: - Methods
extension CustomStepper {
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
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            customLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            customLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
    
    @objc
    private func valueChanged() {
        customLabel.text = "\(Int(value))"
    }
    
}
