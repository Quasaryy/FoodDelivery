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
    // Метод для настройки ячейки с данными из ViewModel
    func configure(with viewModel: StartCollectionViewCellViewModel) {
        foodKindLabel.text = viewModel.categoryName // Установка названия категории
        ImageManager.shared.loadImage(from: viewModel.imageURL, into: foodKindImageView) // Загрузка изображения категории
    }
    
}
