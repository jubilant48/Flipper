//
//  FlippableView.swift
//  Cards
//
//  Created by macbook on 06.01.2023.
//

import UIKit

// MARK: - Protocol

protocol FlippableView: UIView {
    // MARK: - Properties
    
    var backSideType: CardBackSide! { get set }
    var isFlipped: Bool { get set }
    
    // MARK: - Methods
        
    func flip()
    func cleanFlip()
}
