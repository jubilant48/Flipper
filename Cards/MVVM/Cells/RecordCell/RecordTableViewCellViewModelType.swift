//
//  RecordTableViewCellViewModelType.swift
//  Cards
//
//  Created by macbook on 15.05.2023.
//

import UIKit

// MARK: - Protocol

protocol RecordTableViewCellViewModelType {
    var place: String { get }
    var time: String { get }
    var date: String { get }
    var score: String { get }
}
