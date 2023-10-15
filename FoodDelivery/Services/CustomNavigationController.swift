//
//  CustomNavigationController.swift
//  FoodDelivery
//
//  Created by Yury on 09.10.23.
//

import UIKit

class CustomNavigationController: UINavigationController, UINavigationControllerDelegate {
    
    // MARK: - Properties
    private let locationViewModel = LocationManagerViewModel()
    
    // MARK:  - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        locationViewModel.delegate = self
        locationViewModel.fetchCityName()
    }
    
}

// MARK: - Methods
extension CustomNavigationController: LocationManagerViewModelDelegate {
    
    // MARK: LocationManagerViewModelDelegate
    func didUpdateCity(city: String) {
        locationViewModel.city = city
        if let topVC = topViewController {
            setupNavigationBar(for: topVC)
        }
    }
    
    // MARK: UINavigationControllerDelegate
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        locationViewModel.delegate = self
        setupNavigationBar(for: viewController)
    }
    
    // MARK: Setup
    private func setupNavigationBar(for viewController: UIViewController) {
        let locationView = CustomNavigationView()
        navigationBar.shadowImage = UIImage()
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        let date = locationViewModel.date
        locationView.configure(city: locationViewModel.city ?? "Город не определен", date: date)
        
        let locationBarItem = UIBarButtonItem(customView: locationView)
        viewController.navigationItem.leftBarButtonItem = locationBarItem
        
        let userImageView = UIImageView(image: UIImage(named: "UserPhoto"))
        userImageView.contentMode = .scaleAspectFit
        userImageView.bounds = CGRect(x: 0, y: 0, width: 44, height: 44)
        userImageView.layer.cornerRadius = 22
        userImageView.clipsToBounds = true
        let userImageBarItem = UIBarButtonItem(customView: userImageView)
        viewController.navigationItem.rightBarButtonItem = userImageBarItem
        
        if viewControllers.count > 1 { // Если не первый контроллер в стеке
            let backButtonImage = UIImage(named: "ArrowBack")?.withRenderingMode(.alwaysTemplate)
            let backButton = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(backButtonTapped))
            backButton.tintColor = UIColor.black
            backButton.imageInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
            viewController.navigationItem.leftBarButtonItem = backButton
        }
    }
    
    @objc 
    func backButtonTapped() {
        popViewController(animated: true)
    }
    
}
