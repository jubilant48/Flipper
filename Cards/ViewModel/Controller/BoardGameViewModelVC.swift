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
    
    func play(sound: SoundNames) throws {
        try SoundService.play(sound: sound)
    }
}

// MARK: - Beginning game

extension BoardGameViewModelVC {
    func newGame() {
        let game = Game()
        game.cardsCount = cardsParisCounts
        game.generateCard()
        
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
            
            AnimationService.removeCards(arrayOfCards: flippedCards) { self.flippedCards = [] }
    
            self.removeCheckedCardsFromCardView()
            completion()
        } else {
            self.flippedCards.forEach { card in
                (card as! FlippableView).flip()
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

        button.backgroundColor = .getGrayWhiteColor()
        button.layer.cornerRadius = 10
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.gray, for: .highlighted)
        button.setTitle(NameSpaces.newParty.rawValue, for: .normal)
        
        return button
    }
    
    func getTimerButtonView() -> UIButton {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        
        button.backgroundColor = .getGrayWhiteColor()
        button.layer.cornerRadius = 10
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.gray, for: .highlighted)
        button.setTitle("00:00", for: .normal)
        
        return button
    }
    
    func getButtonView(for buttonType: BoardGameButtonType) -> UIButton {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        
        button.backgroundColor = .getGrayWhiteColor()
        button.layer.cornerRadius = 10
        
        if buttonType == .reverse {
            button.setImage(UIImage(systemName: "repeat"), for: .normal)
            button.tintColor = .black
        } else {
            button.setTitle("0", for: .normal)
        }
        
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.gray, for: .highlighted)
        
        return button
    }
    
    func getDismissButton() -> UIButton {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        
        button.setImage(UIImage(systemName: "arrowshape.backward.fill"), for: .highlighted)
        button.setImage(UIImage(systemName: "arrowshape.backward"), for: .normal)
        button.tintColor = .black
        button.setTitleColor(.gray, for: .highlighted)
        button.backgroundColor = .getGrayWhiteColor()
        button.layer.cornerRadius = 10
        
        return button
    }
    
    func getBoardGameView() -> UIView {
        let boardView = UIView()
                
        boardView.layer.cornerRadius = 5
        boardView.layer.borderWidth = 1.9
        boardView.layer.borderColor = UIColor.clear.cgColor
        boardView.clipsToBounds = true
        boardView.backgroundColor = UIColor(red: 0.1, green: 0.9, blue: 0.1, alpha: 0.3)
        
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
            guard let cardView = view as? FlippableView else {
                throw BoardGameViewModelError.conversationError
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
    
    func saveGame() throws {  //from cardView: [UIView]
        game.remainingCards = try createCardsForSave(from: self.cardViews)
        
        do {
            try storage.saveGameData(cardsCount: Int16(game.cardsCount), numberOfCardFlips: Int16(game.numberOfCardFlips), countTouchesOnCard: Int16(countTouchesOnCard), cards: game.remainingCards, second: Int64(timerService.returnSecond()))
        } catch {
            let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            let viewController = scene!.windows[0].rootViewController
            
            UIApplication.getTopViewController(base: viewController)?.showErrorAlert(description: error.localizedDescription)
        }
    }
}
