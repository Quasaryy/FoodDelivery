//
//  StartViewControllerViewModel.swift
//  FoodDelivery
//
//  Created by Yury on 08.10.23.
//

protocol StartScreenViewModelProtocol {
    var dataModelForCuisine: Cuisine { get }
    func fetchData(completion: @escaping () -> Void)
    func category(at index: Int) -> Сategory?
    func numberOfCategories() -> Int
}

class StartViewControllerViewModel: StartScreenViewModelProtocol {
    
    // MARK: - Propertis
    
    var dataModelForCuisine = Cuisine(сategories: [Сategory]())
    let api = "https://run.mocky.io/v3/058729bd-1402-4578-88de-265481fd7d54"
    
}

// MARK: - Methods

extension StartViewControllerViewModel {
    func fetchData(completion: @escaping () -> Void) {
        NetworkManager.shared.fetchData(urlString: api) { [weak self] dataModel in
            self?.dataModelForCuisine = dataModel
            completion()
        }
    }
    
    func category(at index: Int) -> Сategory? {
        if index >= 0 && index < dataModelForCuisine.сategories.count {
            return dataModelForCuisine.сategories[index]
        }
        return nil
    }
    
    func numberOfCategories() -> Int {
        return dataModelForCuisine.сategories.count
    }
    
}
