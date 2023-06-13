//
//  BoardGameView.swift
//  Cards
//
//  Created by macbook on 02.06.2023.
//

import UIKit
import Lottie

// MARK: - Class

final class BoardGameView: UIView, FlippableView {
    // MARK: - Properties
    
    private var cornerRadius: CGFloat = 5
    
    lazy var frontSideView: UIView = self.getFrontSideView()
    lazy var backSideView: LottieAnimationView = self.getBackSideView()
    
    var isFlipped: Bool = true {
        didSet {
            self.setNeedsDisplay()
        }
    }
    var animation: AnimationHelper.Animation
    
    // MARK: - Init
    
    init(frame: CGRect, animation: AnimationHelper.Animation) {
        self.animation = animation
        super.init(frame: frame)
                
        setupBorders()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override method
    
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
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        setupAnimation()
        self.backSideView.play()
    }
    
    // MARK: - Setup view
    
    private func setupBorders() {
        self.clipsToBounds = true
        self.layer.cornerRadius = cornerRadius
    }
    
    private func setupAnimation() {
        switch traitCollection.userInterfaceStyle {
        case .light, .unspecified:
            self.backSideView.animation = LottieAnimation.named(animation.objects.light)
        case .dark:
            self.backSideView.animation = LottieAnimation.named(animation.objects.dark)
        @unknown default:
            break
        }

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
        
        self.setupAnimation()
        UIView.transition(from: fromView, to: toView, duration: 0.5, options: [.transitionFlipFromRight]) { _ in
            if !self.isFlipped {
                self.backSideView.play()
            }
        }
        
        isFlipped.toggle()
    }
}

// MARK: - Front side view and back side view

extension BoardGameView {
    private func getFrontSideView() -> UIView {
        let view = UIView(frame: self.bounds)
        
        view.backgroundColor = .get(color: ._CCCCFF_003153)
        view.layer.masksToBounds = true
        view.layer.cornerRadius = cornerRadius
        view.layer.borderWidth = 1.9
        view.layer.borderColor = UIColor.clear.cgColor
        
        return view
    }
    
    private func getBackSideView() -> LottieAnimationView {
        let animationView = LottieAnimationView(frame: self.bounds)
        
        animationView.backgroundColor = .get(color: ._F0F6F0_25252C)
        animationView.layer.masksToBounds = true
        animationView.layer.cornerRadius = cornerRadius
        animationView.loopMode = animation.objects.loopMode
        
        return animationView
    }
}
