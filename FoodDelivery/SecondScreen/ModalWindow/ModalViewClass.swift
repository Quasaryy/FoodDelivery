//
//  YourModalViewClass.swift
//  FoodDelivery
//
//  Created by Yury on 12.10.23.
//

import UIKit

class ModalViewClass: UIView {
    
    class func instantiateFromNib() -> ModalViewClass? {
        return UINib(nibName: "ModalView", bundle: nil).instantiate(withOwner: nil, options: nil).first as? ModalViewClass
    }
    
}
