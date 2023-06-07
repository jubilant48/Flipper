//
//  FlippableView.swift
//  Cards
//
//  Created by macbook on 07.06.2023.
//

import UIKit

// MARK: - Protocol

protocol FlippableView: UIView {
    // MARK: - Properties
    
    var isFlipped: Bool { get set }
    
    // MARK: - Methods
    
    func flip()
}
