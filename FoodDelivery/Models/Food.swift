//
//  Food.swift
//  FoodDelivery
//
//  Created by Yury on 10.10.23.
//

// MARK: - Food
struct Food: Codable {
    var dishes: [Dish]
}

// MARK: - Dish
struct Dish: Codable {
    let id: Int
    let name: String
    let price: Int
    let weight: Int
    let description: String
    let imageURL: String
    let tegs: [Teg]
    var isFavorite: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id, name, price, weight, description
        case imageURL = "image_url"
        case tegs
    }
}

enum Teg: String, Codable, CaseIterable {
    case allMenu = "Все меню"
    case withRice = "С рисом"
    case withFish = "С рыбой"
    case salats = "Салаты"
}
