//
//  Cards.swift
//  Cards
//
//  Created by macbook on 20.12.2022.
//

import UIKit

final class CardView<ShapeType: ShapeLayerProtocol>: UIView, FlippableView {
    // MARK: - Properties
    
    private var viewModel: CardViewViewModelType!
    
    var color: UIColor!
    var backSideType: CardBackSide!
    
    private var cornerRadius: CGFloat = 20
    private let margin: Int = 10
    
    private lazy var frontSideView: UIView = self.getFrontSideView()
    private lazy var backSideView: UIView = self.getBackSideView()
    
    var isFlipped: Bool = false {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    // MARK: - Init
    
    init(frame: CGRect,
         color: UIColor,
         backSide: CardBackSide = Settings.shared.getCardBackSides().randomElement()!, viewModel: CardViewViewModelType) {
        super.init(frame: frame)
        
        self.viewModel = viewModel
        
        self.color = color
        self.backSideType = backSide
        self.isExclusiveTouch = true
        
        if isFlipped {
            self.addSubview(backSideView)
            self.addSubview(frontSideView)
        } else {
            self.addSubview(frontSideView)
            self.addSubview(backSideView)
        }
        
        setupBorders()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Draw method
    
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
    
    // MARK: - Logic methods
    
    func flip() {
        let fromView = isFlipped ? frontSideView : backSideView
        let toView = isFlipped ? backSideView : frontSideView
        
        viewModel.flipBehavior.beforeFlip(self)
        UIView.transition(from: fromView, to: toView, duration: 0.5, options: [.transitionFlipFromBottom]) { _ in
            do {
                try self.viewModel.flipBehavior.inFlipping(self)
            } catch {
                self.parentViewController?.showErrorAlert(description: error.localizedDescription)
            }
        }
        
        isFlipped.toggle()
    }
    
    func cleanFlip() {
        let fromView = isFlipped ? frontSideView : backSideView
        let toView = isFlipped ? backSideView : frontSideView
        
        UIView.transition(from: fromView, to: toView, duration: 0.5, options: [.transitionCurlDown], completion: nil)
        
        isFlipped.toggle()
    }
    
    // MARK: - update UI
    
    private func setupBorders() {
        self.clipsToBounds = true
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.black.cgColor
    }
    
    // MARK: - Touches methods
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        viewModel.startTouchPoint = frame.origin
        
        viewModel.firstTouch.x = touches.first!.location(in: window).x - frame.minX
        viewModel.firstTouch.y = touches.first!.location(in: window).y - frame.minY
        
        viewModel.touchesBehavior.touchesBegan(self)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)

        self.frame.origin.x = touches.first!.location(in: window).x - viewModel.firstTouch.x
        self.frame.origin.y = touches.first!.location(in: window).y - viewModel.firstTouch.y
        
        viewModel.touchesBehavior.touchesMoved(self)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        let isStartPoint = self.frame.origin == viewModel.startTouchPoint
        
        if isStartPoint {
            flip()
        }

        viewModel.climbBehavior.climb(startPoint: viewModel.startTouchPoint, view: self)
        (viewModel.touchesBehavior as! CardTouchesBehavior).set(isStartPoint: isStartPoint, isFlipped: isFlipped)
        do {
            try self.viewModel.touchesBehavior.touchesEnded(self)
        } catch {
            self.parentViewController?.showErrorAlert(description: error.localizedDescription)
        }
    }
}

// MARK: - FrontSideView and BackSideView

extension CardView {
    private func getFrontSideView() -> UIView {
        let view = UIView(frame: self.bounds)
        
        view.backgroundColor = .white
        view.layer.masksToBounds = true
        view.layer.cornerRadius = cornerRadius
        
        let shapeView = UIView(frame: CGRect(x: margin, y: margin, width: Int(self.bounds.width) - margin * 2, height: Int(self.bounds.height) - margin * 2))
        view.addSubview(shapeView)
        
        let shapeLayer = ShapeType(size: shapeView.frame.size, fillColor: color.cgColor)
        shapeView.layer.addSublayer(shapeLayer)
        
        return view
    }
    
    private func getBackSideView() -> UIView {
        let view = UIView(frame: self.bounds)
        
        view.backgroundColor = .white
        view.layer.masksToBounds = true
        view.layer.cornerRadius = cornerRadius
        
        switch backSideType {
        case .circle:
            let layer = BackSideCircle(size: self.bounds.size, fillColor: UIColor.black.cgColor)
            view.layer.addSublayer(layer)
        case .line:
            let layer = BackSideLine(size: self.bounds.size, fillColor: UIColor.black.cgColor)
            view.layer.addSublayer(layer)
        case .none:
            print("Неизвестна рубашка карты!")
        }
        
        return view
    }
}


