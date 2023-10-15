//
//  SecondCollectionViewCellViewModel.swift
//  FoodDelivery
//
//  Created by Yury on 10.10.23.
//

import Foundation

protocol SecondHorizontalCollectionViewCellViewModelProtocol {
    var tagName: String { get } // Имя тега для отображения
}

class SecondHorizontalCollectionViewCellViewModel: SecondHorizontalCollectionViewCellViewModelProtocol {
    
    // MARK: - Properties
    let tag: Teg // Тег, который будет отображаться в ячейке
    
    var tagName: String {
        return tag.rawValue // Возвращаем имя тега в виде строки
    }
    
    // MARK: - init
    init(tag: Teg) {
        self.tag = tag // Инициализируем объект ViewModel с переданным тегом
    }
    
}
