//
//  CartViewController.swift
//  FoodDelivery
//
//  Created by Yury on 14.10.23.
//

import UIKit

class CartViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var paymentButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    var viewModel: CartViewControllerViewModelProtocol = CartViewControllerViewModel()
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Подписываемся на уведомление
        NotificationCenter.default.addObserver(self, selector: #selector(cartItemQuantityChanged), name: NSNotification.Name("cartItemQuantityChanged"), object: nil)
    }
    
    // MARK: - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        let totalValue = CartManager.shared.totalCartValue()
        paymentButton.setTitle("Оплатить \(UtilityManager.shared.formatNumber(totalValue) ?? "0") ₽", for: .normal)
        paymentButton.isEnabled = CartManager.shared.totalCartValue() > 0
    }
    
    // MARK: - IBActions
    @IBAction func paymentButtonTapped(_ sender: UIButton) {
        // Удаление элементов из корзины
        CartManager.shared.clearCart()
        // Обновление бейджа в таб-баре
        if let tabItems = self.tabBarController?.tabBar.items, !tabItems.isEmpty {
            let cartTabItem = tabItems[2]
            cartTabItem.badgeValue = nil
        }
    }
    
    // MARK: - deinit
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("cartItemQuantityChanged"), object: nil)
    }
    
}

// MARK: - UITableViewDataSource

extension CartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cartCell = tableView.dequeueReusableCell(withIdentifier: "ShoppingCartCell", for: indexPath) as? CartTableViewCell else { return UITableViewCell() }
        
        if let item = viewModel.item(at: indexPath.row) {
            let cellViewModel = CartTableViewCellViewModel(item: item)
            cartCell.configureCell(with: cellViewModel)
            cartCell.delegate = self // Установите себя делегатом
            cartCell.tag = indexPath.row // Установите тег, чтобы идентифицировать ячейку
        }
        
        return cartCell
    }
    
    
    
}

// MARK: - UITableViewDelegate

extension CartViewController: UITableViewDelegate {
    
    
}

extension CartViewController: CartTableViewCellDelegate {
    func stepperValueChanged(at index: Int, newValue: Int) {
        // Обновите модель данных и таблицу на основе индекса и нового значения степпера
        CartManager.shared.updateQuantity(for: CartManager.shared.items[index].dish, to: newValue)
        tableView.reloadData()
        // Проверка на ноль и удаление ячейки
        if newValue == 0 {
            CartManager.shared.removeItem(at: index)
            tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .right)
        }
    }
    
}

// MARK: - Methods
extension CartViewController {
    @objc func cartItemQuantityChanged() {
        // Обновляем бейдж на таббаре с общим количеством товаров
        if let tabItems = self.tabBarController?.tabBar.items, !tabItems.isEmpty {
            let cartTabItem = tabItems[2]
            cartTabItem.badgeValue = CartManager.shared.totalItemsCount() > 0 ? "\(CartManager.shared.totalItemsCount())" : nil
        }
        // Обновляем сумму заказа на кнопке (зависит от вашего интерфейса)
        let totalCartValue = CartManager.shared.totalCartValue()
        paymentButton.setTitle("Оплатить \(UtilityManager.shared.formatNumber(totalCartValue) ?? "0") ₽", for: .normal)
        
        // Отключаем кнопку "Оплатить", если сумма равна нулю или нет товаров в корзине
        paymentButton.isEnabled = totalCartValue > 0
    }
    
}
