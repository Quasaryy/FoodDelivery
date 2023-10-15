//
//  NetworkManager.swift
//  FoodDelivery
//
//  Created by Yury on 09.10.23.
//

import Foundation

class NetworkManager {
    
    // MARK: - Properties
    static let shared = NetworkManager()
    
    // MARK: - Init
    private init() {}
    
}

// MARK: - Methods
extension NetworkManager {
    
    // Метод для получения данных из сети
    func fetchData<T: Decodable>(urlString: String, completion: @escaping (T) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error {
                Logger.logErrorDescription(error) // Логируем описание ошибки
                return
            }
            
            if let response {
                Logger.logResponse(response) // Логируем ответ сервера
            }
            
            guard let remoteData = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let dataModel = try decoder.decode(T.self, from: remoteData)
                DispatchQueue.main.async {
                    completion(dataModel) // Вызываем переданный блок с полученными данными
                }
            } catch let error {
                Logger.logErrorDescription(error) // Логируем описание ошибки при декодировании данных
            }
        }.resume()
    }
    
}
