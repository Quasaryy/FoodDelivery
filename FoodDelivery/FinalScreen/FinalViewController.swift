//
//  FinalViewController.swift
//  FoodDelivery
//
//  Created by Yury on 15.10.23.
//

import UIKit

class FinalViewController: UIViewController {
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: - IBActions
    @IBAction func backToMainScreenButtonTapped(_ sender: UIButton) {
        self.tabBarController?.selectedIndex = 0
        self.navigationController?.popToRootViewController(animated: false)
    }
    
}
