//
//  ImageManager.swift
//  FoodDelivery
//
//  Created by Yury on 11.10.23.
//

import UIKit

class ImageManager {
    
    static let shared = ImageManager()
    
    private init() {}
    
    func loadImage(from url: URL?, into imageView: UIImageView) {
        guard let url = url else { return }
        
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url), let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                imageView.image = image
            }
        }
    }
    
}
