//
//  LocationManagerViewModel.swift
//  FoodDelivery
//
//  Created by Yury on 09.10.23.
//

import Foundation

protocol LocationManagerViewModelDelegate: AnyObject {
    func didUpdateCity(city: String)
}

class LocationManagerViewModel {
    
    // MARK: - Properties
    weak var delegate: LocationManagerViewModelDelegate?
    var city: String?
    var date: String {
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "d MMMM, yyyy"
        return formatter.string(from: currentDate)
    }
    private let locationProvider: LocationProvider
    
    // MARK: - init
    init(locationProvider: LocationProvider = LocationManager()) {
        self.locationProvider = locationProvider
    }
}

// MARK: Methods
extension LocationManagerViewModel {
    func fetchCityName() {
        locationProvider.fetchCityName { cityName in
            let city = cityName ?? "Город не определен"
            self.delegate?.didUpdateCity(city: city)
            Logger.log("Город полученный во ViewModel: \(city)")
        }
    }
    
}
