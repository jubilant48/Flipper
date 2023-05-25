//
//  TouchBehavior.swift
//  Cards
//
//  Created by macbook on 15.03.2023.
//

import UIKit

// MARK: - Protocol

protocol TouchesBehavior {
    // MARK: - Methods
    
    func touchesBegan(_ view: UIView)
    func touchesMoved(_ view: UIView)
    func touchesEnded(_ view: UIView) throws
}
