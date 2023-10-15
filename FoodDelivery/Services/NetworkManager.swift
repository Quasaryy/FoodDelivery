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
    func fetchData<T: Decodable>(urlString: String, completion: @escaping (T) -> Void
    ) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error {
                Logger.logErrorDescription(error)
                return
            }
            
            if let response {
                Logger.logResponse(response)
            }
            
            guard let remoteData = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let dataModel = try decoder.decode(T.self, from: remoteData)
                DispatchQueue.main.async {
                    completion(dataModel)
                }
            } catch let error {
                Logger.logErrorDescription(error)
            }
        }.resume()
    }
    
}
