//
//  Game.swift
//  Cards
//
//  Created by macbook on 20.12.2022.
//

import UIKit

// MARK: - Class

final class Game {
    // MARK: - Properties
    
    static let cardCountNotification = Notification.Name("Game.cardCountEqualZero")
    
    private let settings = Settings.shared
    
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
    
    // MARK: - Methods
    
    func generateCard() throws {
        var cards = [Card]()
        
        for _ in 0 ..< cardsCount {
            guard let randomType = try settings.getCardTypes().randomElement(),
                  let randomColor = try settings.getCardColors().randomElement() else {
                throw CommonError.unwrapFailed(file: #file, line: #line)
            }
            
            let randomElement = Card(type: randomType, color: randomColor)
            
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
    
    // MARK: - Private methods
    
    private func decreaseCardCount() {
        cardsCount -= 1
    }
    
    private func removeCardFromRemainingCards(_ card: Card) {
        if let index = remainingCards.firstIndex(where: { $0.type == card.type && $0.color == card.color }) {
            remainingCards.remove(at: index)
        }
    }
    
}
