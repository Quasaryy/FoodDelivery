//
//  Cuisine.swift
//  FoodDelivery
//
//  Created by Yury on 09.10.23.
//

// MARK: - Cuisine
struct Cuisine: Codable {
    let сategories: [Сategory]
}

// MARK: - Сategory
struct Сategory: Codable {
    let id: Int
    let name: String
    let imageURL: String
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case imageURL = "image_url"
    }
}
