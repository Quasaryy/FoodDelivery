//
//  CustomNavigationController.swift
//  FoodDelivery
//
//  Created by Yury on 09.10.23.
//

import UIKit

class CustomNavigationController: UINavigationController, UINavigationControllerDelegate {
    
    // MARK: - Properties
    
    // Модель данных для управления информацией о местоположении
    private let locationViewModel = LocationManagerViewModel()
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Устанавливаем себя делегатом для навигационного контроллера
        delegate = self
        // Устанавливаем себя делегатом для модели местоположения
        locationViewModel.delegate = self
        // Запрашиваем информацию о городе
        locationViewModel.fetchCityName()
    }
    
}

// MARK: - Methods
extension CustomNavigationController: LocationManagerViewModelDelegate {
    
    // MARK: LocationManagerViewModelDelegate
    
    // Обработчик обновления информации о местоположении
    func didUpdateCity(city: String) {
        // Обновляем информацию о городе в модели местоположения
        locationViewModel.city = city
        // Если есть верхний (текущий) контроллер на стеке
        if let topVC = topViewController {
            // Настраиваем навигационную панель для этого контроллера
            setupNavigationBar(for: topVC)
        }
    }
    
    // MARK: UINavigationControllerDelegate
    
    // Обработчик события перед показом контроллера на экране
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        // Устанавливаем себя делегатом для модели местоположения
        locationViewModel.delegate = self
        // Настраиваем навигационную панель для текущего контроллера
        setupNavigationBar(for: viewController)
    }
    
    // MARK: Setup Navigation Bar
    
    // Настройка навигационной панели
    private func setupNavigationBar(for viewController: UIViewController) {
        // Создаем кастомное представление для отображения информации о местоположении
        let locationView = CustomNavigationView()
        // Устанавливаем фон навигационной панели как прозрачный
        navigationBar.shadowImage = UIImage()
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        // Получаем текущую дату
        let date = locationViewModel.date
        // Конфигурируем кастомное представление с информацией о городе и дате
        locationView.configure(city: locationViewModel.city ?? "Город не определен", date: date)
        
        // Создаем элемент навигационного бара для отображения информации о местоположении
        let locationBarItem = UIBarButtonItem(customView: locationView)
        viewController.navigationItem.leftBarButtonItem = locationBarItem
        
        // Создаем кастомное представление для отображения изображения пользователя
        let userImageView = UIImageView(image: UIImage(named: "UserPhoto"))
        userImageView.contentMode = .scaleAspectFit
        userImageView.bounds = CGRect(x: 0, y: 0, width: 44, height: 44)
        userImageView.layer.cornerRadius = 22
        userImageView.clipsToBounds = true
        
        // Создаем элемент навигационного бара для отображения изображения пользователя
        let userImageBarItem = UIBarButtonItem(customView: userImageView)
        viewController.navigationItem.rightBarButtonItem = userImageBarItem
        
        // Если в стеке есть более одного контроллера (не первый контроллер)
        if viewControllers.count > 1 {
            // Создаем элемент "Назад" с кастомной стрелкой
            let backButtonImage = UIImage(named: "ArrowBack")?.withRenderingMode(.alwaysTemplate)
            let backButton = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(backButtonTapped))
            backButton.tintColor = UIColor.black
            backButton.imageInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
            viewController.navigationItem.leftBarButtonItem = backButton
        }
    }
    
    // Обработчик нажатия кнопки "Назад"
    @objc
    private func backButtonTapped() {
        // Возвращаемся на предыдущий контроллер
        popViewController(animated: true)
    }
    
}
