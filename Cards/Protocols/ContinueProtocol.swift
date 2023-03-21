//
//  ContinueProtocol.swift
//  Cards
//
//  Created by macbook on 27.02.2023.
//

import UIKit

// MARK: - Protocol 

protocol ContinueProtocol {
    func setGameDataFor(_ boardGameController: BoardGameVC, gameData: GameData) throws
}
