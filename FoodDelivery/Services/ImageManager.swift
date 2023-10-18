//
//  ImageManager.swift
//  FoodDelivery
//
//  Created by Yury on 11.10.23.
//

import UIKit

protocol ImageManaging {
    func loadImage(from url: URL?, into imageView: UIImageView)
    func getCachedImageData(from urlString: String) -> Data?
}

class ImageManager {
    
    // MARK: - Properties
    static let shared = ImageManager()
    let imageCache = NSCache<NSString, UIImage>()
    
    // MARK: init
    private init() {}
    
}

// MARK: - Methods
extension ImageManager {
    
    // Метод для загрузки изображения из URL и отображения его в UIImageView
    func loadImage(from url: URL?, into imageView: UIImageView) {
        guard let url else { return }
        
        // Инициализация и настройка активити индикатора
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.center = CGPoint(x: imageView.bounds.size.width / 2, y: imageView.bounds.size.height / 2)
        activityIndicator.hidesWhenStopped = true
        imageView.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        // Проверяем, есть ли изображение в кэше
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            DispatchQueue.main.async {
                imageView.image = cachedImage // Отображаем изображение из кэша
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
            }
            return
        }
        
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url), let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    activityIndicator.stopAnimating()
                    activityIndicator.removeFromSuperview()
                }
                return
            }
            self.imageCache.setObject(image, forKey: url.absoluteString as NSString) // Кэшируем загруженное изображение
            
            DispatchQueue.main.async {
                imageView.image = image // Отображаем загруженное изображение
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
            }
        }
    }
    
    // Метод для получения кэшированных данных изображения по URL
    func getCachedImageData(from urlString: String) -> Data? {
        guard let url = URL(string: urlString),
              let cachedImage = imageCache.object(forKey: url.absoluteString as NSString)
        else {
            return nil
        }
        
        return cachedImage.pngData() // Возвращаем данные PNG изображения
    }
    
}
