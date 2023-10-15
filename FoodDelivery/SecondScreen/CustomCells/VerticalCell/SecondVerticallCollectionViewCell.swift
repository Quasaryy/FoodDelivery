//
//  SecondVerticallCollectionViewCell.swift
//  FoodDelivery
//
//  Created by Yury on 11.10.23.
//

import UIKit

class SecondVerticallCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var foodNameView: UIView!
    @IBOutlet weak var foodImageView: UIImageView!
    
    // MARK: - awakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        foodNameView.layer.cornerRadius = 10
        clipsToBounds = true
    }
    
}

// MARK: - Methods
extension SecondVerticallCollectionViewCell {
    func configure(with viewModel: SecondVerticalCollectionViewCellViewModel) {
        foodNameLabel.text = viewModel.dishName
        ImageManager.shared.loadImage(from: URL(string: viewModel.dishImageUrl), into: foodImageView)
    }
    
}
