//
//  StorageService .swift
//  Cards
//
//  Created by macbook on 30.01.2023.
//

import UIKit
import CoreData

// MARK: - Class

final class StorageService {
    // MARK: Properties
    
    static let shared = StorageService()
    
    private let context: NSManagedObjectContext!
    
    // MARK: Init
    
    init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.context = appDelegate.persistentContainer.viewContext
    }
    
    // MARK: Methods
    
    private func removeGameData() {
        let fetchRequest: NSFetchRequest<GameData> = GameData.fetchRequest()
        
        if let gameData = try? context.fetch(fetchRequest) {
            for object in gameData {
                context.delete(object)
            }
        }
    }
    
    private func saveCardData(cards: [Card], setCards: NSMutableOrderedSet) throws {
        try cards.forEach { (card) in
            let cardData = CardData(context: context)
            
            cardData.cardType = card.type.rawValue
            cardData.cardColor = card.color.rawValue
            
            guard let setViews = cardData.views?.mutableCopy() as? NSMutableOrderedSet else {
                throw StorageServiceError.missingPointSet
            }
            
            card.viewData.forEach { view in
                let viewData = ViewData(context: context)
                
                let point = view.point
                let isFlipped = view.isFlipped
                let back = view.back.rawValue
                
                viewData.x = Float(point.x)
                viewData.y = Float(point.y)
                viewData.isFlipped = isFlipped
                viewData.backSideType = back
                
                setViews.add(viewData)
            }
            
            cardData.views = setViews
            
            setCards.add(cardData)
        }
    }
    
    func saveGameData(cardsCount: Int16, numberOfCardFlips: Int16, countTouchesOnCard: Int16, cards: [Card]) throws {
        removeGameData()
        
        guard let entity = NSEntityDescription.entity(forEntityName: "GameData", in: context) else {
            throw StorageServiceError.entityNotFound
        }
        
        let gameDataObject = GameData(entity: entity, insertInto: context)
        guard let setCards = gameDataObject.cards?.mutableCopy() as? NSMutableOrderedSet else {
            throw StorageServiceError.missingCardSet
        }
        
        gameDataObject.numberOfCardFlips = numberOfCardFlips
        gameDataObject.cardsCount = cardsCount
        gameDataObject.countTouchesOnCard = countTouchesOnCard

        try saveCardData(cards: cards, setCards: setCards)
        
        gameDataObject.cards = setCards
        
        do {
            try context.save()
        } catch let error as NSError {
            throw error
        }
    }
    
    func getGameData() throws -> [GameData] {
        let fetchRequest: NSFetchRequest<GameData> = GameData.fetchRequest()
        var gameData: [GameData] = []
        
        do {
            gameData = try context.fetch(fetchRequest)
        } catch let error as NSError {
            throw error
        }
        
        return gameData
    }
}
