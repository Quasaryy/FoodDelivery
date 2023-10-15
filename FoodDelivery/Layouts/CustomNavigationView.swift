//
//  CustomNavigationView.swift
//  FoodDelivery
//
//  Created by Yury on 08.10.23.
//

import UIKit

// Кастомное представление для отображения информации о местоположении и дате.
class CustomNavigationView: UIView {
    
    // MARK: - Properties
    
    // Иконка местоположения
    let locationImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Location"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // Отображения названия города
    let cityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Regular", size: 18)
        label.textColor = .black
        return label
    }()
    
    // Отображения даты
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        label.textColor = UIColor(white: 0, alpha: 0.5)
        return label
    }()
    
    // MARK: - inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(locationImageView)
        addSubview(cityLabel)
        addSubview(dateLabel)
        
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Определение констрентов
            locationImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            locationImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -6),
            locationImageView.widthAnchor.constraint(equalToConstant: 24),
            locationImageView.heightAnchor.constraint(equalToConstant: 24),
            
            cityLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 4),
            cityLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -9), // Смещение немного вверх
            cityLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -4),
            
            dateLabel.leadingAnchor.constraint(equalTo: cityLabel.leadingAnchor),
            dateLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 4),
            dateLabel.trailingAnchor.constraint(equalTo: cityLabel.trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Methods
extension CustomNavigationView {
    // Конфигурация представления с указанием города и даты
    func configure(city: String, date: String) {
        cityLabel.text = city
        dateLabel.text = date
    }
    
}
