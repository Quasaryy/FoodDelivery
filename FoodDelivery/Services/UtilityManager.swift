//
//  UtilityManager.swift
//  FoodDelivery
//
//  Created by Yury on 14.10.23.
//

import Foundation

class UtilityManager {
    
    // MARK: - Propertis
    static let shared = UtilityManager()
    
    // MARK: - init
    private init() {}
    
}

// MARK: - Methods
extension UtilityManager {
    func formatNumber(_ number: Int) -> String? {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = " "
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: number))
    }
    
}
