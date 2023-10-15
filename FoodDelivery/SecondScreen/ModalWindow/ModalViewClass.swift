//
//  YourModalViewClass.swift
//  FoodDelivery
//
//  Created by Yury on 12.10.23.
//

import UIKit

class ModalViewClass: UIView {
    
    // MARK: - Properties
    var badgeManager: TabBarBadgeManager? // Менеджер бейджей для таб-бара
    var viewModel: ModalViewClassViewModelProtocol? // ViewModel для модального окна
    var parentTabBarController: UITabBarController? // Родительский контроллер таб-бара
    
    // MARK: - IBOutlets
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var foodDescriptionLabel: UILabel!
    @IBOutlet weak var weightLable: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var viewWithImage: UIView!
    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var addToCartButton: UIButton!
    
    
    // MARK: - awakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    // MARK: - IBAcitons
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        // Закрытие модального окна с анимацией
        AnimationManager.shared.animateModalViewDisappearance(self) {
            self.removeFromSuperview()
            self.removeDimmingEffect()
        }
    }
    
    @IBAction func heartButtonTapped(_ sender: UIButton) {
        // Переключение статуса "Избранное"
        viewModel?.toggleFavorite()
        updateHeartButtonAppearance()
    }
    
    @IBAction func addToCartButtonTapped(_ sender: Any) {
        // Добавление товара в корзину
        viewModel?.addItemToCart()
    }
    
}

// MARK: - Methods
extension ModalViewClass {
    // Создание экземпляра класса из Nib
    class func instantiateFromNib() -> ModalViewClass? {
        return UINib(nibName: "ModalView", bundle: nil).instantiate(withOwner: nil, options: nil).first as? ModalViewClass
    }
    
    // Настройка внешнего вида элементов интерфейса
    func setupView() {
        closeButton.layer.cornerRadius = 8
        heartButton.layer.cornerRadius = 8
        addToCartButton.layer.cornerRadius = 10
        viewWithImage.layer.cornerRadius = 10
        self.layer.cornerRadius = 15
    }
    
    // Конфигурация модального окна с использованием ViewModel
    func configure(with viewModel: ModalViewClassViewModelProtocol) {
        self.viewModel = viewModel
        foodNameLabel.text = viewModel.dishName
        foodDescriptionLabel.text = viewModel.dishDescription
        priceLabel.text = viewModel.price
        weightLable.text = viewModel.weight
        if let imageData = viewModel.imageData {
            let image = UIImage(data: imageData)
            foodImageView.image = image
        }
        updateHeartButtonAppearance()
        self.viewModel?.onUpdateCartBadge = { [weak self] in
            self?.updateCartBadge()
        }
    }
    
    // Удаление затемнения под модальным окном
    func removeDimmingEffect() {
        guard let tabBarView = self.parentTabBarController?.view else { return }
        if let dimmingView = tabBarView.viewWithTag(1234) {
            dimmingView.removeFromSuperview()
        }
    }
    
    // Обновление внешнего вида кнопки "Избранное"
    func updateHeartButtonAppearance() {
        guard let viewModel else { return }
        heartButton.setImage(UIImage(systemName: viewModel.isFavorite ? "suit.heart.fill" : "suit.heart"), for: .normal)
        heartButton.tintColor = viewModel.isFavorite ? .red : .black
    }
    
    // Обновление бейджа корзины
    func updateCartBadge() {
        let itemCount = CartManager.shared.totalItemsCount()
        badgeManager?.updateCartBadge(with: itemCount)
    }
    
}
