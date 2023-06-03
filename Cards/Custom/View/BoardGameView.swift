//
//  BoardGameView.swift
//  Cards
//
//  Created by macbook on 02.06.2023.
//

import UIKit

// MARK: - Class

final class BoardGameView: UIView {
    // MARK: - Properties
    
    private var cornerRadius: CGFloat = 5
    
    lazy var frontSideView: UIView = self.getFrontSideView()
    lazy var backSideView: UIView = self.getBackSideView()
    
    var isFlipped: Bool = true {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        setupBorders()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Daraw method
    
    override func draw(_ rect: CGRect) {
        backSideView.removeFromSuperview()
        frontSideView.removeFromSuperview()
        
        if isFlipped {
            self.addSubview(backSideView)
            self.addSubview(frontSideView)
        } else {
            self.addSubview(frontSideView)
            self.addSubview(backSideView)
        }
    }
    
    
    // MARK: - Setup view
    
    private func setupBorders() {
        self.clipsToBounds = true
        self.layer.cornerRadius = cornerRadius
    }
    
    func setupFlipView() {
        if isFlipped {
            self.addSubview(backSideView)
            self.addSubview(frontSideView)
        } else {
            self.addSubview(frontSideView)
            self.addSubview(backSideView)
        }
    }
    
    // MARK: - Methods
    
    func flip() {
        let fromView = isFlipped ? frontSideView : backSideView
        let toView = isFlipped ? backSideView : frontSideView
        
        UIView.transition(from: fromView, to: toView, duration: 0.5, options: [.transitionFlipFromRight], completion: nil)
        
        isFlipped.toggle()
    }
}

// MARK: - Front side view and back side view

extension BoardGameView {
    private func getFrontSideView() -> UIView {
        let view = UIView(frame: self.bounds)
        
        view.backgroundColor = .getBoardColor()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = cornerRadius
        view.layer.borderWidth = 1.9
        view.layer.borderColor = UIColor.clear.cgColor
        
        return view
    }
    
    private func getBackSideView() -> UIView {
        let view = UIView(frame: self.bounds)
        
        view.backgroundColor = .getTimerButtonColor()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = cornerRadius
        
        return view
    }
}
