//
//  Game.swift
//  Cards
//
//  Created by macbook on 20.12.2022.
//

import UIKit

// MARK: - Class

final class Game {
    // MARK: Properties
    
    static let cardCountNotification = Notification.Name("Game.cardCountEqualZero")
    
    var cardsCount: Int = 0 {
        didSet {
            if cardsCount == 0 {
                NotificationCenter.default.post(name: Game.cardCountNotification, object: nil)
            }
        }
    }
    var numberOfCardFlips: Int = 0
    var allExistingCards = [Card]() {
        didSet {
            remainingCards = allExistingCards
        }
    }
    var remainingCards = [Card]()
    
    // MARK: Methods
    
    func generateCard() {
        var cards = [Card]()
        
        for _ in 0..<cardsCount {
            let randomElement = Card(type: Settings.shared.getCardTypes().randomElement()!, color: Settings.shared.getCardColors().randomElement()!)
            
            cards.append(randomElement)
        }
        
        self.allExistingCards = cards
    }
    
    func checkCards(_ firstCard: Card, _ secondCard: Card) -> Bool {        
        if firstCard == secondCard {
            removeCardFromRemainingCards(firstCard)
            decreaseCardCount()
            return true
        }
        return false
    }
    
    func increaseCountOfCardFlips() {
        numberOfCardFlips += 1
    }
    
    // MARK: Private methods
    
    private func decreaseCardCount() {
        cardsCount -= 1
    }
    
    private func removeCardFromRemainingCards(_ card: Card) {
        if let index = remainingCards.firstIndex(where: { $0.type == card.type && $0.color == card.color }) {
            remainingCards.remove(at: index)
        }
    }
    
}
