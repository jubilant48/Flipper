//
//  UIButton + Extension.swift
//  Cards
//
//  Created by macbook on 09.01.2023.
//

import UIKit

// MARK: - Extension

extension UIButton {
    // MARK: - Init
    
    convenience init(title: String, titleColor: UIColor, backgroundColor: UIColor,
                     font: UIFont?, isShadow: Bool = false, cornerRadius: CGFloat = 10) {
        self.init(type: .system)
        
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = backgroundColor
        self.titleLabel?.font = font
        self.layer.cornerRadius = cornerRadius
        
        if isShadow {
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowRadius = 4
            self.layer.shadowOpacity = 0.2
            self.layer.shadowOffset = CGSize(width: 0, height: 4)
        }
    }
}

