//
//  BoardGameViewViewModelType.swift
//  Cards
//
//  Created by macbook on 07.03.2023.
//

import UIKit

// MARK: - Protocol

protocol BoardGameViewViewModelType {
    // MARK: - Properties
    
    var cardViews: [UIView] { get set }
    var flippedCards: [UIView] { get set }
    
    var margin: CGFloat { get }
    var isShowReverseCardsButton: Bool { get }
    var cardsParisCounts: Int { get }
    var cardSize: CGSize { get }
    
    var isContinueGame: Bool { get set }
    var countTouchesOnCard: Int { get set }
    
    var timerService: TimerService { get }
    var game: Game! { get set }

    // MARK: - Setup subview
    
    func getStartButtonView() -> UIButton
    func getTimerButtonView() -> UIButton
    func getButtonView(for buttonType: BoardGameButtonType) -> UIButton
    func getDismissButton() -> UIButton
    func getBoardGameView() throws -> BoardGameView
    
    // MARK: - Methods
    
    func getViewModelforCardView() -> CardViewViewModelType
    
    // MARK: - Beginning game
    
    func newGame() throws
    func getRandomPoint(from rect: CGRect) -> CGPoint
    
    // MARK: - Game methods
    
    func checkCards(firstCard: Card, secondCard: Card, completion: () -> Void) throws
    
    // MARK: - Remove and Reset
    
    func removeCheckedCardsFromCardView()
    func removeCardFromSubview() 
    
    // MARK: - Storage
    
    func saveGame() throws
    func saveRecord() throws
}
