//
//  UtilityManager.swift
//  FoodDelivery
//
//  Created by Yury on 14.10.23.
//

import Foundation

class UtilityManager {
    
    static let shared = UtilityManager()
    
    private init() {}
    
    func formatNumber(_ number: Int) -> String? {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = " "
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: number))
    }
    
}
