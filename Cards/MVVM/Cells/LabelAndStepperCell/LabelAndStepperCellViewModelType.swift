//
//  LabelAndStepperCellViewModelType.swift
//  Cards
//
//  Created by macbook on 17.02.2023.
//

import UIKit

// MARK: - Protocol

protocol LabelAndStepperCellViewModelType {
    // MARK: - Properties
    
    var title: String { get }
    var currentValue: Int { get }
}
