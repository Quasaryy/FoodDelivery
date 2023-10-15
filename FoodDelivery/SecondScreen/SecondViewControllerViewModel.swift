//
//  SecondViewControllerViewModel.swift
//  FoodDelivery
//
//  Created by Yury on 10.10.23.
//

protocol SecondViewControllerViewModelProtocol {
    var dataModelForFood: Food { get }
    func fetchData(completion: @escaping () -> Void)
    func tag(at index: Int) -> Teg?
    func dish(at index: Int) -> Dish?
    func numberOfTags() -> Int
    func numberOfDishes() -> Int
    func filteredDishes(forTag tag: Teg) -> [Dish]
    func updateFavoriteStatus(forDishId id: Int, isFavorite: Bool)
    func getCategoryName() -> String
    func setCategoryName(_ name: String)
}

class SecondViewControllerViewModel: SecondViewControllerViewModelProtocol {
    
    // MARK: - Propertis
    var dataModelForFood = Food(dishes: [Dish]())
    private let api = "https://run.mocky.io/v3/aba7ecaa-0a70-453b-b62d-0e326c859b3b"
    private var categoryName: String = ""
    
}

// MARK: - Methods
extension SecondViewControllerViewModel {
    func getCategoryName() -> String {
        return categoryName
    }
    
    func setCategoryName(_ name: String) {
        self.categoryName = name
    }
    
    func fetchData(completion: @escaping () -> Void) {
        NetworkManager.shared.fetchData(urlString: api) { [weak self] dataModel in
            self?.dataModelForFood = dataModel
            completion()
        }
    }
    
    func tag(at index: Int) -> Teg? {
        guard index >= 0 && index < Teg.allCases.count else { return nil }
        return Teg.allCases[index]
    }
    
    func numberOfTags() -> Int {
        return Teg.allCases.count
    }
    
    func dish(at index: Int) -> Dish? {
        guard index >= 0 && index < dataModelForFood.dishes.count else {
            return nil
        }
        return dataModelForFood.dishes[index]
    }
    
    func numberOfDishes() -> Int {
        return dataModelForFood.dishes.count
    }
    
    func filteredDishes(forTag tag: Teg) -> [Dish] {
        return dataModelForFood.dishes.filter { $0.tegs.contains(tag) }
    }
    
    func updateFavoriteStatus(forDishId id: Int, isFavorite: Bool) {
        if let index = dataModelForFood.dishes.firstIndex(where: { $0.id == id }) {
            dataModelForFood.dishes[index].isFavorite = isFavorite
        }
    }
    
}
