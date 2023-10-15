//
//  CartTableViewCell.swift
//  FoodDelivery
//
//  Created by Yury on 14.10.23.
//

import UIKit

protocol CartTableViewCellDelegate: AnyObject {
    func stepperValueChanged(at index: Int, newValue: Int)
}

class CartTableViewCell: UITableViewCell {
    
    var currentItem: CartItem?
    weak var delegate: CartTableViewCellDelegate?
    
    
    @IBOutlet weak var stepper: CustomStepper!
    @IBOutlet weak var priceAndWeightLabel: UILabel!
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var viewBehindImage: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        stepper.layer.cornerRadius = 10
        stepper.backgroundColor = .clear
        viewBehindImage.layer.cornerRadius = 6
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func stepperValueChanged(_ sender: CustomStepper) {
                let newValue = Int(sender.value)
                delegate?.stepperValueChanged(at: self.tag, newValue: newValue)
            
            // Отправка уведомления
            NotificationCenter.default.post(name: NSNotification.Name("cartItemQuantityChanged"), object: nil)
        
    }
    
}

extension CartTableViewCell {
    func configureCell(with viewModel: CartTableViewCellViewModel) {
        if let url = URL(string: viewModel.imageURL) {
            ImageManager.shared.loadImage(from: url, into: foodImage)
        }
        foodNameLabel.text = viewModel.name
        priceAndWeightLabel.text = viewModel.priceAndWeight
        stepper.value = viewModel.quantity
        currentItem = viewModel.item
    }
}
