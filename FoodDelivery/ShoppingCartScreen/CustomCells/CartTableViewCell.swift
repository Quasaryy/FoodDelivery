//
//  CartTableViewCell.swift
//  FoodDelivery
//
//  Created by Yury on 14.10.23.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var stepper: UIStepper!
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

}

extension CartTableViewCell {
    func congifureCell() {
        foodImage.image = UIImage(named: "Rice")
        foodNameLabel.text = "Супер ппупер"
        priceAndWeightLabel.text = "100р за ща 100г"
    }
}
