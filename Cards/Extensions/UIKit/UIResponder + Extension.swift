//
//  UIResponder + Extension.swift
//  Cards
//
//  Created by macbook on 15.03.2023.
//

import UIKit

// MARK: - Extension

extension UIResponder {
    // MARK: - Properties
    
    public var parentViewController: UIViewController? {
        return next as? UIViewController ?? next?.parentViewController
    }
}
