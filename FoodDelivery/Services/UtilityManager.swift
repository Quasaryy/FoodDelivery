//
//  UtilityManager.swift
//  FoodDelivery
//
//  Created by Yury on 14.10.23.
//

import Foundation

// Менеджер для утилитарных операций
class UtilityManager {
    
    // MARK: - Properties
    static let shared = UtilityManager()
    
    // Форматтер для форматирования чисел с разделителем тысяч
    private let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = " " // Разделитель тысяч
        formatter.numberStyle = .decimal // Формат числа с разделителем
        return formatter
    }()
    
    // MARK: - init
    private init() {}
    
}

// MARK: - Methods
extension UtilityManager {
    // Метод для форматирования числа с разделителем тысяч
    func formatNumber(_ number: Int) -> String? {
        objc_sync_enter(self) // Синхронизация для потокобезопасности
        let result = numberFormatter.string(from: NSNumber(value: number))
        objc_sync_exit(self) // Завершение синхронизации
        return result
    }
}
