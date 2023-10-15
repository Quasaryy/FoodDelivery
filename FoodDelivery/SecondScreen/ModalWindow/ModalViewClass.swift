//
//  YourModalViewClass.swift
//  FoodDelivery
//
//  Created by Yury on 12.10.23.
//

import UIKit

class ModalViewClass: UIView {
    
    // MARK: - Properties
    var badgeManager: TabBarBadgeManager?
    var viewModel: ModalViewClassViewModelProtocol?
    var parentTabBarController: UITabBarController?
    
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
        AnimationManager.shared.animateModalViewDisappearance(self) {
            self.removeFromSuperview()
            self.removeDimmingEffect()
        }
    }
    
    @IBAction func heartButtonTapped(_ sender: UIButton) {
        viewModel?.toggleFavorite()
        updateHeartButtonAppearance()
    }
    
    @IBAction func addToCartButtonTapped(_ sender: Any) {
        viewModel?.addItemToCart()
    }
    
}

// MARK: - Methods
extension ModalViewClass {
    class func instantiateFromNib() -> ModalViewClass? {
        return UINib(nibName: "ModalView", bundle: nil).instantiate(withOwner: nil, options: nil).first as? ModalViewClass
    }
    
    func setupView() {
        closeButton.layer.cornerRadius = 8
        heartButton.layer.cornerRadius = 8
        addToCartButton.layer.cornerRadius = 10
        viewWithImage.layer.cornerRadius = 10
        self.layer.cornerRadius = 15
        
    }
    
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
    
    
    func removeDimmingEffect() {
        guard let tabBarView = self.parentTabBarController?.view else { return }
        if let dimmingView = tabBarView.viewWithTag(1234) {
            dimmingView.removeFromSuperview()
        }
    }
    
    func updateHeartButtonAppearance() {
        guard let viewModel = viewModel else { return }
        heartButton.setImage(UIImage(systemName: viewModel.isFavorite ? "suit.heart.fill" : "suit.heart"), for: .normal)
        heartButton.tintColor = viewModel.isFavorite ? .red : .black
    }
    
    func updateCartBadge() {
        let itemCount = CartManager.shared.totalItemsCount()
        badgeManager?.updateCartBadge(with: itemCount)
    }
    
}
