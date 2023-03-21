//
//  UIStackView + Extension.swift
//  Cards
//
//  Created by macbook on 09.01.2023.
//

import UIKit

// MARK: - Extension

extension UIStackView {
    // MARK: - Init
    
    convenience init(arrangedSubviews: [UIView], axis: NSLayoutConstraint.Axis, spacing: CGFloat) {
        self.init(arrangedSubviews: arrangedSubviews)
        
        self.axis = axis
        self.spacing = spacing
    }
}
