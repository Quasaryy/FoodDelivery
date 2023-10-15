//
//  ImageManager.swift
//  FoodDelivery
//
//  Created by Yury on 11.10.23.
//

import UIKit

class ImageManager {
    
    // MARK: - Properties
    static let shared = ImageManager()
    let imageCache = NSCache<NSString, UIImage>()
    
    
    // MARK: init
    private init() {}
    
}

// MARK: - Methods
extension ImageManager {
    func loadImage(from url: URL?, into imageView: UIImageView) {
        guard let url = url else { return }
        
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            DispatchQueue.main.async {
                imageView.image = cachedImage
            }
            return
        }
        
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url), let image = UIImage(data: data) else { return }
            self.imageCache.setObject(image, forKey: url.absoluteString as NSString)
            DispatchQueue.main.async {
                imageView.image = image
            }
        }
    }
    
    func getCachedImageData(from urlString: String) -> Data? {
        guard let url = URL(string: urlString),
              let cachedImage = imageCache.object(forKey: url.absoluteString as NSString)
        else {
            return nil
        }
        
        return cachedImage.pngData()
    }
    
}
