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
        guard let imageUrl = viewModel.imageURL else { return }
        DispatchQueue.global().async {
            guard let dataImage = try? Data(contentsOf: imageUrl) else { return }
            DispatchQueue.main.async {
                self.foodKindImageView.image = UIImage(data: dataImage)
            }
        }
    }
}
