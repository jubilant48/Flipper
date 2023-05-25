//
//  ViewInfo.swift
//  Cards
//
//  Created by macbook on 07.02.2023.
//

import UIKit

// MARK: - Class

final class ViewInfo {
    // MARK: Properties
    
    var back: CardBackSide
    var isFlipped: Bool
    var point: CGPoint
    
    // MARK: Init
    
    init(back: CardBackSide, isFlipped: Bool, point: CGPoint) {
        self.back = back
        self.isFlipped = isFlipped
        self.point = point
    }
}
