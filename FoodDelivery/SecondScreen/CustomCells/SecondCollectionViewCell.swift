//
//  SecondCollectionViewCell.swift
//  FoodDelivery
//
//  Created by Yury on 10.10.23.
//

import UIKit

class SecondCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var foodTag: UILabel!
    
    // MARK: - awakeFromNib
    
    override func awakeFromNib() {
            super.awakeFromNib()
            
            layer.cornerRadius = 10
            clipsToBounds = true
        }
    
}

// MARK: - Methods

extension SecondCollectionViewCell {
    func configure(with viewModel: SecondCollectionViewCellViewModel) {
        foodTag.text = viewModel.tagName
    }
}
