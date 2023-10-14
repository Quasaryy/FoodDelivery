//
//  CartViewController.swift
//  FoodDelivery
//
//  Created by Yury on 14.10.23.
//

import UIKit

class CartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

// MARK: - UITableViewDataSource

extension CartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cartCell = tableView.dequeueReusableCell(withIdentifier: "ShoppingCartCell", for: indexPath) as? CartTableViewCell else { return UITableViewCell() }
        
        cartCell.congifureCell()
        
        return cartCell
    }
    
    
    
}

// MARK: - UITableViewDelegate

extension CartViewController: UITableViewDelegate {
    
    
}
