//
//  Card.swift
//  Cards
//
//  Created by macbook on 20.12.2022.
//

import UIKit

// MARK: - Structure

final class Card: Equatable {
    // MARK: Properties
    
    var type: CardType
    var color: CardColor
    var viewData: [ViewInfo] = []
    
    // MARK: Init
    
    init(type: CardType, color: CardColor) {
        self.type = type
        self.color = color
    }
    
    // MARK: Methods
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return (lhs.type == rhs.type) && (lhs.color == rhs.color)
    }
}
