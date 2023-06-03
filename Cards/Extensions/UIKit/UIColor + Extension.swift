//
//  UIColor + Extension.swift
//  Cards
//
//  Created by macbook on 09.01.2023.
//

import UIKit

// MARK: - Extension

extension UIColor {
    // MARK: - Methods
    
    static func getGrayWhiteColor() -> UIColor {
        guard let color = UIColor(named: "GrayWhite") else {
            fatalError("Not found color GreyWhite in scope")
        }
        return color
    }
    
    static func getWhiteGrayColor() -> UIColor {
        guard let color = UIColor(named: "WhiteGray") else {
            fatalError("Not found color WhiteGray in scope")
        }
        return color
    }
    
    static func getTimerButtonColor() -> UIColor {
        guard let color = UIColor(named: "F0F6F0#25252C") else {
            fatalError("Not found color WhiteGray in scope")
        }
        return color
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
     
