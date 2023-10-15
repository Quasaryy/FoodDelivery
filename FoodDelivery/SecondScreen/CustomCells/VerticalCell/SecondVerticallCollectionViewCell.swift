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
        // Устанавливаем скругленные углы для foodNameView
        foodNameView.layer.cornerRadius = 10
        clipsToBounds = true
    }
    
}

// MARK: - Methods
extension SecondVerticallCollectionViewCell {
    // Настройка ячейки с данными из ViewModel
    func configure(with viewModel: SecondVerticalCollectionViewCellViewModelProtocol) {
        foodNameLabel.text = viewModel.dishName
        
        // Загрузка изображения блюда из указанного URL
        ImageManager.shared.loadImage(from: URL(string: viewModel.dishImageUrl), into: foodImageView)
    }
    
}
