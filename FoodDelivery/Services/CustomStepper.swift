//
//  CustomStepper.swift
//  FoodDelivery
//
//  Created by Yury on 14.10.23.
//

import UIKit

class CustomStepper: UIStepper {
    
    private var customLabel: UILabel!
    private let customFont = UIFont(name: "SFProDisplay-Medium", size: 14)!
    private var plusButton: UIButton!
    private var minusButton: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        let clearImage = UIImage()
        setDecrementImage(clearImage, for: .normal)
        setIncrementImage(clearImage, for: .normal)
        
        self.tintColor = .clear
        
        let minusImage = UIImage(named: "StepperMinis")
        minusButton = UIButton(type: .custom)
        minusButton.setImage(minusImage, for: .normal)
        minusButton.translatesAutoresizingMaskIntoConstraints = false
        minusButton.addTarget(self, action: #selector(decrementValue), for: .touchUpInside)
        minusButton.addTarget(self, action: #selector(handleButtonDown(_:)), for: .touchDown)
        minusButton.addTarget(self, action: #selector(handleButtonUp(_:)), for: [.touchUpInside, .touchUpOutside, .touchCancel])
        addSubview(minusButton)

        let plusImage = UIImage(named: "StepperPlus")
        plusButton = UIButton(type: .custom)
        plusButton.setImage(plusImage, for: .normal)
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        plusButton.addTarget(self, action: #selector(incrementValue), for: .touchUpInside)
        plusButton.addTarget(self, action: #selector(handleButtonDown(_:)), for: .touchDown)
        plusButton.addTarget(self, action: #selector(handleButtonUp(_:)), for: [.touchUpInside, .touchUpOutside, .touchCancel])
        addSubview(plusButton)
        
        customLabel = UILabel()
        customLabel.textAlignment = .center
        customLabel.font = customFont
        customLabel.bounds = CGRect(x: 0, y: 0, width: 24, height: 24)
        customLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(customLabel)
        
        customLabel.text = "\(Int(value))"
        
        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            customLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            customLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            minusButton.centerYAnchor.constraint(equalTo: customLabel.centerYAnchor),
            minusButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 6),
            plusButton.centerYAnchor.constraint(equalTo: customLabel.centerYAnchor),
            plusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -6)
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

    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        return false
    }

    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        return false
    }
    
    @objc private func handleButtonDown(_ sender: UIButton) {
        AnimationManager.shared.animateButtonDown(sender)
    }

    @objc private func handleButtonUp(_ sender: UIButton) {
        AnimationManager.shared.animateButtonUp(sender)
    }
}
