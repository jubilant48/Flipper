//
//  BoardGameViewModelVC.swift
//  Cards
//
//  Created by macbook on 07.03.2023.
//

import UIKit

final class BoardGameViewModelVC: BoardGameViewViewModelType {
    // MARK: - Properties
    
    private var settings = Settings.shared
    private var storage = StorageService.shared
    
    var cardViews: [UIView] = [UIView]()
    var flippedCards: [UIView] = [UIView]()
    
    var margin: CGFloat { 10 }
    var isShowReverseCardsButton: Bool { settings.isShowReverseCardsButton }
    var cardsParisCounts: Int { settings.numberPairsCards }
    var cardSize: CGSize { CGSize(width: 80, height: 120) }
    
    var isContinueGame: Bool = false
    var countTouchesOnCard: Int = 0
    
    var timerService: TimerService = TimerService()
    
    var game: Game!
    
    // MARK: - Init
    
    init(isContinue: Bool) {
        self.isContinueGame = isContinue
    }
    
    // MARK: - Methods
    
    func getRandomPoint(from rect: CGRect) -> CGPoint {
        let cardMaxXCoordinate = Int(rect.width - cardSize.width)
        let cardMaxYCoordinate = Int(rect.height - cardSize.height)
        
        let randomXCoordinate = Int.random(in: 0...cardMaxXCoordinate)
        let randomYCoordinate = Int.random(in: 0...cardMaxYCoordinate)
        
        return CGPoint(x: randomXCoordinate, y: randomYCoordinate)
    }
}

// MARK: - Beginning game

extension BoardGameViewModelVC {
    func newGame() throws {
        let game = Game()
        game.cardsCount = cardsParisCounts
        try game.generateCard()
        
        self.game = game
    }
}

// MARK: - Game methods

extension BoardGameViewModelVC {
    func checkCards(firstCard: Card, secondCard: Card, completion: () -> Void) throws {
        if game.checkCards(firstCard, secondCard) {
            let flippedCards = self.flippedCards
            
            if cardViews.count == 2 {
                try SoundService.play(sound: .showScoreSheet)
            } else {
                try SoundService.play(sound: .remove)
            }
            
            AnimationHelper.removeCards(arrayOfCards: flippedCards) { self.flippedCards = [] }
    
            self.removeCheckedCardsFromCardView()
            completion()
        } else {
            self.flippedCards.forEach { card in
                (card as! FlippableCard).flip()
                completion()
            }
        }
    }
}

// MARK: - Remove and Reset

extension BoardGameViewModelVC {
    func removeCheckedCardsFromCardView() {
        for view in cardViews {
            if view == self.flippedCards.first {
                let firstIndex = cardViews.firstIndex(of: self.flippedCards.first!)
                
                cardViews.remove(at: firstIndex!)
            }
            
            if view == self.flippedCards.last {
                let lastIndex = cardViews.lastIndex(of: self.flippedCards.last!)
                
                cardViews.remove(at: lastIndex!)
            }
        }
    }
    
    func removeCardFromSubview() {
        cardViews.forEach { card in
            card.removeFromSuperview()
        }
    }
}

// MARK: - Get subview

extension BoardGameViewModelVC {
    func getStartButtonView() -> UIButton {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))

        button.backgroundColor = .get(color: ._F0F6F0_25252C)
        button.layer.cornerRadius = 10
        button.setTitleColor(.getBlue(), for: .normal)
        button.setTitleColor(.gray, for: .highlighted)
        
        button.setTitle(NameSpaces.newParty.rawValue, for: .normal)
        
        return button
    }
    
    func getTimerButtonView() -> UIButton {
        let button = TimerButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50), text: "00:00")
        
        button.backgroundColor = .get(color: ._F0F6F0_25252C)
        button.setTitleColor(.getBlue(), for: .normal)
        
        return button
    }
    
    func getButtonView(for buttonType: BoardGameButtonType) -> UIButton {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        
        if buttonType == .reverse {
            button.setImage(UIImage(systemName: "repeat"), for: .normal)
            button.tintColor = .getBlue()
        } else {
            button.setTitle("0", for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        }
        
        button.setTitleColor(.getBlue(), for: .normal)

        return button
    }
    
    func getDismissButton() -> UIButton {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        button.tintColor = .getBlue()
        
        return button
    }
    
    func getBoardGameView() throws -> BoardGameView {
        let animation = try Settings.shared.getBoardAnimation()
        
        let boardView = BoardGameView(frame: .zero, animation: animation)
        
        return boardView
    }
    
    func getViewModelforCardView() -> CardViewViewModelType {
        return CardViewModelView()
    }
}

// MARK: - Save game

extension BoardGameViewModelVC {
    private func createCardsForSave(from cardViews: [UIView]) throws -> [Card] {
        var cards = [Card]()
        
        for view in cardViews {
            guard let cardView = view as? FlippableCard else {
                throw CommonError.conversationFiled(file: #file, line: #line)
            }
            
            if cards.contains(game.allExistingCards[view.tag]) {
                
                cards.forEach { card in
                    if card == game.allExistingCards[view.tag] {
                        card.viewData.append(ViewInfo(back: cardView.backSideType, isFlipped: cardView.isFlipped, point: cardView.frame.origin))
                    }
                }
                
            } else {
                let card = game.allExistingCards[view.tag]
                
                card.viewData.append(ViewInfo(back: cardView.backSideType, isFlipped: cardView.isFlipped, point: cardView.frame.origin))
                cards.append(card)
            }
        }
        
        return cards
    }
    
    func saveGame() throws {
        game.remainingCards = try createCardsForSave(from: self.cardViews)
        
        do {
            try storage.saveGameData(cardsCount: Int16(game.cardsCount), numberOfCardFlips: Int16(game.numberOfCardFlips), countTouchesOnCard: Int16(countTouchesOnCard), cards: game.remainingCards, second: Int64(timerService.returnSecond()))
        } catch {
            let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            let viewController = scene!.windows[0].rootViewController
            
            UIApplication.getTopViewController(base: viewController)?.showErrorAlert(description: error.localizedDescription)
        }
    }
    
    func saveRecord() throws {
        let second: Int64 = Int64(timerService.returnSecond())
        let flips: Int64 = Int64(game.numberOfCardFlips)
        let date: Date = Date()
        
        let numberOfPairsCards: Int16 = Int16(settings.numberPairsCards)
        let numberOfTypes: Int16 = Int16(settings.cardTypes.count)
        let numberOfColors: Int16 = Int16(settings.cardColors.count)
        
        let record = Record(numberOfPairsCards: numberOfPairsCards,
                            numberOfTypes: numberOfTypes,
                            numberOfColors: numberOfColors,
                            second: second,
                            date: date,
                            flips: flips)
        
        try storage.saveRecordData(from: record)
    }
}
