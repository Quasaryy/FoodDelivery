//
//  Cuisine.swift
//  FoodDelivery
//
//  Created by Yury on 09.10.23.
//

import Foundation

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

extension Cuisine {
    static func getDataModel() -> Cuisine  {
        return Cuisine(сategories: [
            Сategory(id: Int(), name: String(), imageURL: String())
        ])
    }
}
