//
//  SecondViewControllerViewModel.swift
//  FoodDelivery
//
//  Created by Yury on 10.10.23.
//

protocol SecondViewModelProtocol {
    var dataModelForFood: Food { get }
    func fetchData(completion: @escaping () -> Void)
    func tag(at index: Int) -> Teg?
    func numberOfTags() -> Int
}

class SecondViewControllerViewModel: SecondViewModelProtocol {
    
    // MARK: - Propertis
    
    var dataModelForFood = Food(dishes: [Dish]())
    let api = "https://run.mocky.io/v3/aba7ecaa-0a70-453b-b62d-0e326c859b3b"
    
}

// MARK: - Methods

extension SecondViewControllerViewModel {
    func fetchData(completion: @escaping () -> Void) {
        NetworkManager.shared.fetchData(urlString: api) { [weak self] dataModel in
            self?.dataModelForFood = dataModel
            completion()
        }
    }
    
    func tag(at index: Int) -> Teg? {
        return Teg.allCases[index]
    }
    
    func numberOfTags() -> Int {
        return Teg.allCases.count
    }
    
}

