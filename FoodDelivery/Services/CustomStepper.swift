//
//  CustomStepper.swift
//  FoodDelivery
//
//  Created by Yury on 14.10.23.
//

import UIKit

class CustomStepper: UIStepper {
    
    private var customLabel: UILabel!
    
    override var value: Double {
        didSet {
            customLabel.text = "\(Int(value))"
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        customLabel = UILabel()
        customLabel.textAlignment = .center
        customLabel.font = UIFont(name: "SFProDisplay-Medium", size: 14)
        customLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(customLabel)
        
        customLabel.text = "\(Int(value))"
        
        setIncrementImage(UIImage(named: "StepperPlus"), for: .normal)
        setDecrementImage(UIImage(named: "StepperMinis"), for: .normal)
        
        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            customLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            customLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }

    @objc private func decrementValue() {
        if value > minimumValue {
            value -= stepValue
            customLabel.text = "\(Int(value))"
        }
    }

    @objc private func incrementValue() {
        if value < maximumValue {
            value += stepValue
            customLabel.text = "\(Int(value))"
        }
    }
}
