//
//  StartCollectionViewCell.swift
//  FoodDelivery
//
//  Created by Yury on 09.10.23.
//

import UIKit

class StartCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var foodKindImageView: UIImageView!
    @IBOutlet weak var foodKindLabel: UILabel!
    
}

// MARK: - Methods

extension StartCollectionViewCell {
    func configure(with viewModel: StartCollectionViewCellViewModel) {
        foodKindLabel.text = viewModel.categoryName
        ImageManager.shared.loadImage(from: viewModel.imageURL, into: foodKindImageView)
    }
    
}
