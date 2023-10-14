//
//  SecondCollectionViewCell.swift
//  FoodDelivery
//
//  Created by Yury on 10.10.23.
//

import UIKit

class SecondHorizontalCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var foodTag: UILabel!
    
    // MARK: - awakeFromNib
    
    override func awakeFromNib() {
            super.awakeFromNib()
            layer.cornerRadius = 10
        }
    
}

// MARK: - Methods

extension SecondHorizontalCollectionViewCell {
    func configure(with viewModel: SecondHorizontalCollectionViewCellViewModel) {
        foodTag.text = viewModel.tagName
    }
    
}
