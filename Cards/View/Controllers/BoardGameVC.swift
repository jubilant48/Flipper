//
//  BoardGameVC.swift
//  Cards
//
//  Created by macbook on 20.12.2022.
//

import UIKit

final class BoardGameVC: UIViewController {
    // MARK: - Properties
    
    var viewModel: BoardGameViewViewModelType!
    
    private lazy var startButtonView = viewModel.getStartButtonView()
    private lazy var timerButtonView = viewModel.getTimerButtonView()
    lazy var buttonForNumberOfCardFlips = viewModel.getButtonView(for: .restart)
    private lazy var reverseCardsButtonView = viewModel.getButtonView(for: .reverse)
    lazy var dismissButton = viewModel.getDismissButton()
    private lazy var boardGameView = viewModel.getBoardGameView()
    
    var timer: Timer?
    var second: Int = 0
    var timerIsRinning: Bool = true
    
    // MARK: - Init
    
    init(viewModel: BoardGameViewViewModelType) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func loadView() {
        super.loadView()
        
        addingSubviews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        registerNotifications()
        
        if !viewModel.isContinueGame {
            startGame()
        } else {
            viewModel.isContinueGame.toggle()
            updateViewForContinueGame()
        }
    }
    
    // MARK: - Update UI
    
    private func addingSubviews() {
        setupDismissButton()
        view.addSubview(dismissButton)
        
        if viewModel.isShowReverseCardsButton {
            setupStartButtonView()
            view.addSubview(startButtonView)
            
            setup(button: reverseCardsButtonView)
            addTargetFor(buttonType: .reverse)
            view.addSubview(reverseCardsButtonView)
        } else {
            setupTimerButtonView()
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            view.addSubview(timerButtonView)
            
            setup(button: buttonForNumberOfCardFlips)
            addTargetFor(buttonType: .restart)
            view.addSubview(buttonForNumberOfCardFlips)
        }
        
        setupBoardGameView()
        view.addSubview(boardGameView)
    }
    
    func resetTouchesOnCard() {
        viewModel.countTouchesOnCard = 0
        
        self.boardGameView.isUserInteractionEnabled = true
        self.dismissButton.isEnabled = true
    }
}

// MARK: - Game methods

extension BoardGameVC {
    func startGame() {
        viewModel.newGame()
        
        let cards = getCardsBy(modelData: viewModel.game.allExistingCards)
        resetGame()
        placeCardsOnBoard(cards)
    }
    
    private func resetGame() {
        viewModel.countTouchesOnCard = 0
        viewModel.flippedCards = []

        second = 0
        buttonForNumberOfCardFlips.setTitle("0", for: .normal)
        timerButtonView.setTitle("00:00", for: .normal)
    }
    
    private func getCardsBy(modelData: [Card], isContinue: Bool = false) -> [UIView] {
        var cardView = [UIView]()
        let cardViewFactory = CardViewFactory()
        let cardViewModel = viewModel.getViewModelforCardView()
        
        if !isContinue {
            for (index, modelCard) in modelData.enumerated() {
                let cardOne = cardViewFactory.get(modelCard.type, withSize: viewModel.cardSize, andColor: modelCard.color, viewModel: cardViewModel)
                cardOne.tag = index
                cardView.append(cardOne)
                
                let cardTwo = cardViewFactory.get(modelCard.type, withSize: viewModel.cardSize, andColor: modelCard.color, viewModel: cardViewModel)
                cardTwo.tag = index
                cardView.append(cardTwo)
            }
        } else {
            for (index, modelCard) in modelData.enumerated() {
                for data in modelCard.viewData {
                    let card = cardViewFactory.get(modelCard.type, withSize: viewModel.cardSize, andColor: modelCard.color, andBackSide: data.back, viewModel: cardViewModel)
                    card.tag = index
                    card.frame.origin = data.point
                    (card as? FlippableView)?.isFlipped = data.isFlipped
                    cardView.append(card)
                    
                    if data.isFlipped {
                        viewModel.flippedCards.append(card)
                    }
                }
                
                modelCard.viewData = []
            }
        }
        
        return cardView
    }
    
    private func placeCardsOnBoard(_ cards: [UIView], isContinue: Bool = false) {
        viewModel.removeCardFromSubview()
        viewModel.cardViews = cards
        
        viewModel.cardViews.forEach { card in
            if !isContinue {
                card.frame.origin = viewModel.getRandomPoint(from: boardGameView.frame)
            }
            
            boardGameView.addSubview(card)
        }
    }
    
}

// MARK: - Continue game

extension BoardGameVC {
    private func updateViewForContinueGame() {
        buttonForNumberOfCardFlips.setTitle("\(viewModel.game.numberOfCardFlips)", for: .normal)

        let cards = getCardsBy(modelData: viewModel.game.allExistingCards, isContinue: true)
        placeCardsOnBoard(cards, isContinue: true)
    }
}

// MARK: - Actions

extension BoardGameVC {
    @objc func startNewGameWithAlert() {
        self.showStartNewGameAlert(description: "Количество переворотов карт \(viewModel.game.numberOfCardFlips)") {
            self.startGame()
        } quitCompletion: {
            self.dismiss(animated: true)
        }
    }
    
    @objc private func updateTimer() {
        second += 1
        
        timerButtonView.setTitle(timeFormatted(second), for: .normal)
    }
    
    @objc private func switchTimer() {
        
        if timerIsRinning {
            timer?.invalidate()
            timer = nil
            
            UIView.animate(withDuration: 0.5) {
                self.timerButtonView.backgroundColor = .getBlue()
                self.boardGameView.backgroundColor = .blue
                self.boardGameView.isUserInteractionEnabled = false
            }
        } else {
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            
            UIView.animate(withDuration: 0.5) {
                self.timerButtonView.backgroundColor = .getGrayWhiteColor()
                self.boardGameView.backgroundColor = UIColor(red: 0.1, green: 0.9, blue: 0.1, alpha: 0.3)
                self.boardGameView.isUserInteractionEnabled = true
            }
        }
        
        timerIsRinning.toggle()
    }
    
    @objc private func startGameTapped(_ sender: UIButton) {
        do {
            try viewModel.play(sound: .click)
        } catch {
            self.showErrorAlert(description: error.localizedDescription)
        }
        
        startGame()
    }
    
    @objc func dismissToMenu(_ sender: UIButton) {
        do {
            try viewModel.saveGame()
            try viewModel.play(sound: .backToMenu)
        } catch {
            showErrorAlert(description: error.localizedDescription)
        }
        self.dismiss(animated: true)
    }
    
    @objc func reverseCards(_ sender: UIButton) {
        do {
            try viewModel.play(sound: .click)
        } catch {
            self.showErrorAlert(description: error.localizedDescription)
        }
        
        viewModel.flippedCards = []
        viewModel.countTouchesOnCard = 0
        
        var flippedCards: [FlippableView] = []
        var noFlippedCards: [FlippableView] = []
        
        viewModel.cardViews.forEach { card in
            let flippedCard = (card as! FlippableView)
            
            if flippedCard.isFlipped {
                flippedCards.append(flippedCard)
            } else {
                noFlippedCards.append(flippedCard)
            }
        }
        
        if flippedCards.count == viewModel.cardViews.count {
            flippedCards.forEach { flippedCard in
                flippedCard.cleanFlip()
            }
        } else if noFlippedCards.count == viewModel.cardViews.count {
            noFlippedCards.forEach { flippedCard in
                flippedCard.cleanFlip()
            }
        } else if flippedCards.count > 0 {
            noFlippedCards.forEach { flippedCard in
                flippedCard.cleanFlip()
            }
        }
    }
}

// MARK: - Setup view

extension BoardGameVC {
    private func registerNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(startNewGameWithAlert), name: Game.cardCountNotification, object: nil)
    }
    
    private func setupView() {
        view.backgroundColor = .getWhiteGrayColor()
        view.isMultipleTouchEnabled = false
        view.isExclusiveTouch = true
    }
    
    private func setupInCenter(_ myView: UIView) {
        myView.center.x = view.center.x
        myView.frame.origin.y = getTopPadding()
    }
    
    private func setupStartButtonView() {
        setupInCenter(startButtonView)
        
        startButtonView.addTarget(self, action: #selector(startGameTapped), for: .touchUpInside)
    }
    
    private func setupTimerButtonView() {
        setupInCenter(timerButtonView)
        
        timerButtonView.addTarget(self, action: #selector(switchTimer), for: .touchUpInside)
    }
    
    private func setup(button: UIButton) {
        button.frame.origin.y = getTopPadding()
        button.frame.origin.x = getWindow().frame.width - viewModel.margin - button.bounds.width
    }
    
    private func addTargetFor(buttonType: BoardGameButtonType) {
        if buttonType == .reverse {
            reverseCardsButtonView.addTarget(self, action: #selector(reverseCards), for: .touchUpInside)
        } else {
            buttonForNumberOfCardFlips.addTarget(self, action: #selector(startGameTapped), for: .touchUpInside)
        }
    }
    
    private func setupDismissButton() {
        dismissButton.frame.origin.y = getTopPadding()
        dismissButton.frame.origin.x = viewModel.margin
        
        dismissButton.addTarget(self, action: #selector(dismissToMenu), for: .touchUpInside)
    }
    
    private func setupBoardGameView() {
        boardGameView.frame.origin.x = viewModel.margin
        boardGameView.frame.origin.y = getTopPadding() + dismissButton.frame.height + viewModel.margin
        boardGameView.frame.size.width = UIScreen.main.bounds.width - viewModel.margin * 2
        boardGameView.frame.size.height = UIScreen.main.bounds.height - boardGameView.frame.origin.y - viewModel.margin - getBottomPadding()
    }
}

