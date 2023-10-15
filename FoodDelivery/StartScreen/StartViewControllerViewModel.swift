//
//  StartViewControllerViewModel.swift
//  FoodDelivery
//
//  Created by Yury on 08.10.23.
//

// Протокол для ViewModel контроллера начального экрана
protocol StartViewControllerViewModelProtocol {
    var dataModelForCuisine: Cuisine { get } // Модель данных для кухни
    func fetchData(completion: @escaping () -> Void) // Загрузка данных
    func category(at index: Int) -> Category? // Получение категории по индексу
    func numberOfCategories() -> Int // Получение количества категорий
}

class StartViewControllerViewModel: StartViewControllerViewModelProtocol {
    
    // MARK: - Propertis
    var dataModelForCuisine = Cuisine(categories: [Category]()) // Модель данных для кухни
    let api = "https://run.mocky.io/v3/058729bd-1402-4578-88de-265481fd7d54" // URL для загрузки данных
    
}

// MARK: - Methods
extension StartViewControllerViewModel {
    // Метод для загрузки данных
    func fetchData(completion: @escaping () -> Void) {
        NetworkManager.shared.fetchData(urlString: api) { [weak self] dataModel in
            self?.dataModelForCuisine = dataModel
            completion()
        }
    }
    
    // Метод для получения категории по индексу
    func category(at index: Int) -> Category? {
        if index >= 0 && index < dataModelForCuisine.categories.count {
            return dataModelForCuisine.categories[index]
        }
        return nil
    }
    
    // Метод для получения количества категорий
    func numberOfCategories() -> Int {
        return dataModelForCuisine.categories.count
    }
    
}
