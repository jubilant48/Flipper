//
//  CardViewFactory.swift
//  Cards
//
//  Created by macbook on 26.12.2022.
//

import UIKit

// MARK: - Class

final class CardViewFactory {
    // MARK: Methods
    
    func  get(_ shape: CardType, withSize size: CGSize, andColor color: CardColor, viewModel: CardViewViewModelType) -> UIView {
        let frame = CGRect(origin: .zero, size: size)
        let viewColor = getViewColorBy(modelColor: color)
        
        switch shape {
        case .circle:
            return CardView<CircleShape>(frame: frame, color: viewColor, viewModel: viewModel)
        case .cross:
            return CardView<CrossShape>(frame: frame, color: viewColor, viewModel: viewModel)
        case .square:
            return CardView<SquareShape>(frame: frame, color: viewColor, viewModel: viewModel)
        case .fill:
            return CardView<FillShape>(frame: frame, color: viewColor, viewModel: viewModel)
        }
    }
    
    func  get(_ shape: CardType, withSize size: CGSize, andColor color: CardColor, andBackSide backSide: CardBackSide, viewModel: CardViewViewModelType) -> UIView {
        let frame = CGRect(origin: .zero, size: size)
        let viewColor = getViewColorBy(modelColor: color)
        
        switch shape {
        case .circle:
            return CardView<CircleShape>(frame: frame, color: viewColor, backSide: backSide, viewModel: viewModel)
        case .cross:
            return CardView<CrossShape>(frame: frame, color: viewColor, backSide: backSide, viewModel: viewModel)
        case .square:
            return CardView<SquareShape>(frame: frame, color: viewColor, backSide: backSide, viewModel: viewModel)
        case .fill:
            return CardView<FillShape>(frame: frame, color: viewColor, backSide: backSide, viewModel: viewModel)
        }
    }
    
    // MARK: Private methods
    
    private func getViewColorBy(modelColor: CardColor) -> UIColor {
        switch modelColor {
        case .black:
            return .black
        case .red:
            return .red
        case .green:
            return .green
        case .gray:
            return .gray
        case .brown:
            return .brown
        case .yellow:
            return .yellow
        case .purple:
            return .purple
        case .orange:
            return .orange
        case .white:
            return .white
        }
    }
}
