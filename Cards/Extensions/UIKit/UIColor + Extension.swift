//
//  UIColor + Extension.swift
//  Cards
//
//  Created by macbook on 09.01.2023.
//

import UIKit

// MARK: - Extension

extension UIColor {
    // MARK: - Enumeration
    
    enum AssetName: String {
        // MARK: - Cases
        
        case _F0F6F0_25252C = "F0F6F0_25252C"
        case _FFFFFF_1E1E1E = "FFFFFF_1E1E1E"
        case _D1D1D6_FFFFFF = "D1D1D6_FFFFFF"
        
        // MARK: - Properties
        
        typealias Value = String
        var name: String { getValue() }
        
        // MARK: - Methods
        
        private func getValue() -> Value {
            switch self {
            case ._F0F6F0_25252C:
                return rawValue
            case ._FFFFFF_1E1E1E:
                return rawValue
            case ._D1D1D6_FFFFFF:
                return rawValue
            }
        }
    }
    
    // MARK: - Methods
    
    static func get(color asset: AssetName) -> UIColor {
        switch asset {
        case ._F0F6F0_25252C:
            return UIColor(named: asset.name)!
        case ._FFFFFF_1E1E1E:
            return UIColor(named: asset.name)!
        case ._D1D1D6_FFFFFF:
            return UIColor(named: asset.name)!
        }
    }
    
    static func getLimeColor() -> UIColor {
        return #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
    }
    
    static func getGreen() -> UIColor {
        return #colorLiteral(red: 0.2174892128, green: 0.8184008598, blue: 0, alpha: 1)
    }
    
    static func getMercuryColor() -> UIColor {
        return #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
    }
    
    static func buttonDark() -> UIColor {
        return #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
    }
    
    static func textFieldLight() -> UIColor {
        return #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1)
    }
    
    static func getBlue() -> UIColor {
        return #colorLiteral(red: 0, green: 0.4431372549, blue: 0.8901960784, alpha: 1)
    }
    
    static func getBoardColor() -> UIColor {
        return #colorLiteral(red: 0, green: 0.1921568627, blue: 0.3254901961, alpha: 1)
    }
    
    static func getRed() -> UIColor {
        return #colorLiteral(red: 1, green: 0.1491002738, blue: 0, alpha: 1)
    }
}
     
