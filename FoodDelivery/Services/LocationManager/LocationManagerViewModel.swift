//
//  LocationManagerViewModel.swift
//  FoodDelivery
//
//  Created by Yury on 09.10.23.
//

import Foundation

class LocationManagerViewModel {
    
    // MARK: - Properties
    
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
    func fetchCityName(completion: @escaping (String?) -> Void) {
        locationProvider.fetchCityName { cityName in
            completion(cityName)
        }
    }
    
}
