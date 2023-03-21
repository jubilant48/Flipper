//
//  UILabel + Extesion.swift
//  Cards
//
//  Created by macbook on 09.01.2023.
//

import UIKit

// MARK: - Extension

extension UILabel {
    // MARK: - Init
    
    convenience init(text: String, font: UIFont? = .getCharter17()) {
        self.init()
        
        self.text = text
        self.font = font
    }
}
