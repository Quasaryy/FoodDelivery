//
//  LocationManager.swift
//  FoodDelivery
//
//  Created by Yury on 09.10.23.
//

import CoreLocation

// Протокол для предоставления информации о местоположении
protocol LocationProvider {
    func fetchCityName(completion: @escaping (String?) -> Void)
}

class LocationManager: NSObject, CLLocationManagerDelegate, LocationProvider {
    
    // MARK: - Properties
    
    private var locationManager = CLLocationManager()
    private var geocoder = CLGeocoder()
    private var completion: ((String?) -> Void)?
    
    // MARK: - init
    
    // Инициализатор класса LocationManager
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
}

// MARK: - Methods
extension LocationManager {
    
    // Запрос информации о городе
    func fetchCityName(completion: @escaping (String?) -> Void) {
        self.completion = completion
        locationManager.startUpdatingLocation()
        
        // Задержка перед остановкой обновления местоположения
        DispatchQueue.main.asyncAfter(deadline: .now() + 30.0) {
            self.locationManager.stopUpdatingLocation()
        }
    }
    
    // Обработчик обновления местоположения
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        Logger.log("Получены координаты местоположения.")
        guard let location = locations.last else { return }
        
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            Logger.log("Обратное геокодирование выполнено. Ошибки: \(String(describing: error))")
            guard let placemark = placemarks?.first, error == nil else {
                self.completion?(nil)
                return
            }
            if let city = placemark.locality {
                Logger.log("Определенный город: \(city)")
                DispatchQueue.main.async {
                    self.completion?(city)
                }
            } else {
                DispatchQueue.main.async {
                    self.completion?(nil)
                }
            }
        }
    }
    
    // Обработчик ошибки при получении местоположения
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        Logger.log("Ошибка при получении местоположения: \(error.localizedDescription)")
    }
    
    // Обработчик изменения статуса авторизации
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        Logger.log("Статус авторизации изменился: \(status.rawValue)")
    }
    
}
