//
//  SecondViewControllerViewModel.swift
//  FoodDelivery
//
//  Created by Yury on 10.10.23.
//

// Протокол, описывающий интерфейс для ViewModel второго экрана
protocol SecondViewControllerViewModelProtocol {
    var dataModelForFood: Food { get } // Модель данных для блюд
    func fetchData(completion: @escaping () -> Void) // Метод для загрузки данных
    func tag(at index: Int) -> Teg? // Получение тега по индексу
    func dish(at index: Int) -> Dish? // Получение блюда по индексу
    func numberOfTags() -> Int // Получение количества тегов
    func numberOfDishes() -> Int // Получение количества блюд
    func filteredDishes(forTag tag: Teg) -> [Dish] // Фильтрация блюд по тегу
    func updateFavoriteStatus(forDishId id: Int, isFavorite: Bool) // Обновление статуса "Избранное" для блюда
    func getCategoryName() -> String // Получение названия категории
    func setCategoryName(_ name: String) // Установка названия категории
}

class SecondViewControllerViewModel: SecondViewControllerViewModelProtocol {
    
    // MARK: - Propertis
    var dataModelForFood = Food(dishes: [Dish]()) // Модель данных для блюд
    private let api = "https://run.mocky.io/v3/aba7ecaa-0a70-453b-b62d-0e326c859b3b" // URL для загрузки данных с сервера
    private var categoryName: String = "" // Название категории
    
}

// MARK: - Methods
extension SecondViewControllerViewModel {
    // Получение названия категории
    func getCategoryName() -> String {
        return categoryName
    }
    
    // Установка названия категории
    func setCategoryName(_ name: String) {
        self.categoryName = name
    }
    
    // Загрузка данных с сервера
    func fetchData(completion: @escaping () -> Void) {
        NetworkManager.shared.fetchData(urlString: api) { [weak self] dataModel in
            self?.dataModelForFood = dataModel
            completion()
        }
    }
    
    // Получение тега по индексу
    func tag(at index: Int) -> Teg? {
        guard index >= 0 && index < Teg.allCases.count else { return nil }
        return Teg.allCases[index]
    }
    
    // Получение количества тегов
    func numberOfTags() -> Int {
        return Teg.allCases.count
    }
    
    // Получение блюда по индексу
    func dish(at index: Int) -> Dish? {
        guard index >= 0 && index < dataModelForFood.dishes.count else {
            return nil
        }
        return dataModelForFood.dishes[index]
    }
    
    // Получение количества блюд
    func numberOfDishes() -> Int {
        return dataModelForFood.dishes.count
    }
    
    // Фильтрация блюд по тегу
    func filteredDishes(forTag tag: Teg) -> [Dish] {
        return dataModelForFood.dishes.filter { $0.tegs.contains(tag) }
    }
    
    // Обновление статуса "Избранное" для блюда
    func updateFavoriteStatus(forDishId id: Int, isFavorite: Bool) {
        if let index = dataModelForFood.dishes.firstIndex(where: { $0.id == id }) {
            dataModelForFood.dishes[index].isFavorite = isFavorite
        }
    }
    
}
