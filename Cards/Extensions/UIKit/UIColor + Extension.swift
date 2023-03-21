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
        guard let grayWhiteColor = UIColor(named: "GrayWhite") else {
            fatalError("Not found color GreyWhite in scope")
        }
        return grayWhiteColor
    }
    
    static func getWhiteGrayColor() -> UIColor {
        guard let whiteGrayColor = UIColor(named: "WhiteGray") else {
            fatalError("Not found color WhiteGray in scope")
        }
        return whiteGrayColor
    }
    
    static func getLimeColor() -> UIColor {
        return #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
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
}
     