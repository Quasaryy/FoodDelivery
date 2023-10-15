//
//  CartTableViewCell.swift
//  FoodDelivery
//
//  Created by Yury on 14.10.23.
//

import UIKit

// Протокол делегата для ячейки корзины
protocol CartTableViewCellDelegate: AnyObject {
    func stepperValueChanged(at index: Int, newValue: Int) // Метод вызывается при изменении значения степпера
}

class CartTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    var currentItem: CartItem? // Текущий элемент корзины
    weak var delegate: CartTableViewCellDelegate? // Слабая ссылка на делегата
    
    // MARK: - IBOutlets
    @IBOutlet weak var stepper: CustomStepper!
    @IBOutlet weak var priceAndWeightLabel: UILabel!
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var viewBehindImage: UIView!
    
    // MARK: - awakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        stepper.layer.cornerRadius = 10 // Устанавливаем скругление у степпера
        stepper.backgroundColor = .clear
        viewBehindImage.layer.cornerRadius = 6 // Устанавливаем скругление у вью за изображением
    }
    
    // MARK: - setSelected
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - IBActions
    @IBAction func stepperValueChanged(_ sender: CustomStepper) {
        let newValue = Int(sender.value)
        delegate?.stepperValueChanged(at: self.tag, newValue: newValue) // Вызываем метод делегата при изменении значения степпера
        // Отправка уведомления о изменении количества элементов корзины
        NotificationCenter.default.post(name: NSNotification.Name("cartItemQuantityChanged"), object: nil)
    }
    
}

// MARK: - Methods
extension CartTableViewCell {
    func configureCell(with viewModel: CartTableViewCellViewModel) {
        if let url = URL(string: viewModel.imageURL) {
            ImageManager.shared.loadImage(from: url, into: foodImage) // Загружаем изображение из URL
        }
        foodNameLabel.text = viewModel.name // Устанавливаем название продукта
        priceAndWeightLabel.text = viewModel.priceAndWeight // Устанавливаем цену и вес продукта
        stepper.value = viewModel.quantity // Устанавливаем значение степпера
        currentItem = viewModel.item // Устанавливаем текущий элемент корзины
    }
    
}
