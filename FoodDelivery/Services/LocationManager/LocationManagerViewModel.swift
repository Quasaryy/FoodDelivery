//
//  LocationManagerViewModel.swift
//  FoodDelivery
//
//  Created by Yury on 09.10.23.
//

import Foundation

// Протокол для обратной связи с делегатом
protocol LocationManagerViewModelDelegate: AnyObject {
    func didUpdateCity(city: String)
}

class LocationManagerViewModel {
    
    // MARK: - Properties
    
    // Слабая ссылка на делегата
    weak var delegate: LocationManagerViewModelDelegate?
    
    // Город
    var city: String?
    
    // Текущая дата в формате "день месяца, год"
    var date: String {
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "d MMMM, yyyy"
        return formatter.string(from: currentDate)
    }
    
    // Поставщик информации о местоположении
    private let locationProvider: LocationProvider
    
    // MARK: - init
    
    // Инициализатор ViewModel с возможностью внедрения зависимости для тестирования
    init(locationProvider: LocationProvider = LocationManager()) {
        self.locationProvider = locationProvider
    }
}

// MARK: Methods
extension LocationManagerViewModel {
    
    // Запрос города
    func fetchCityName() {
        locationProvider.fetchCityName { cityName in
            let city = cityName ?? "Город не определен"
            self.delegate?.didUpdateCity(city: city)
            Logger.log("Город полученный во ViewModel: \(city)")
        }
    }
    
}
