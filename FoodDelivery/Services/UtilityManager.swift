//
//  UtilityManager.swift
//  FoodDelivery
//
//  Created by Yury on 14.10.23.
//

import Foundation

class UtilityManager {
    
    // MARK: - Properties
    static let shared = UtilityManager()
    
    private let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = " "
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    // MARK: - init
    private init() {}
    
}

// MARK: - Methods
extension UtilityManager {
    func formatNumber(_ number: Int) -> String? {
        objc_sync_enter(self)
        let result = numberFormatter.string(from: NSNumber(value: number))
        objc_sync_exit(self)
        return result
    }
}

