//
//  MenuViewModelVC.swift
//  Cards
//
//  Created by macbook on 27.02.2023.
//

import UIKit

final class MenuViewModelVC: MenuViewViewModelType {
    // MARK: - Properties
    
    private var settings = Settings.shared
    private var storage = StorageService.shared
    
    var backTitleButton: String {
        return NameSpaces.menu.rawValue
    }
    var navigationBarPrefersLargeTitles: Bool {
        return true
    }
    var backgroundColor: UIColor {
        return .getWhiteGrayColor()
    }
    
    // MARK: - Methods
    
    func getBoardGameViewController(isContinue: Bool) -> BoardGameVC {
        let boardGameController = BoardGameVC(viewModel: viewModelForBoardGameVC(isContinue: isContinue))
        boardGameController.modalPresentationStyle = .fullScreen
        
        return boardGameController
    }
    
    private func viewModelForBoardGameVC(isContinue: Bool) -> BoardGameViewViewModelType {
        return BoardGameViewModelVC(isContinue: isContinue)
    }
    
    func viewModelForSttings() -> SettingsTableViewViewModelType {
        return SettingsViewModelTVC()
    }
    
    func viewModelForRecords() -> RecordsTableViewViewModelType {
        return NumberOfPairsCardsViewModelTVC()
    }
}

// MARK: - Subview

extension MenuViewModelVC {
    func getGameNameLabel() -> UILabel {
        let gameLabel = UILabel(text: NameSpaces.gameName.rawValue, font: .getCharter55())
        
        gameLabel.translatesAutoresizingMaskIntoConstraints = false
        gameLabel.textAlignment = .center
        
        return gameLabel
    }
    
    func getButton(for buttonType: MenuButtonType) -> UIButton {
        return UIButton(title: buttonType.name, titleColor: .black, backgroundColor: .getGrayWhiteColor(), font: .getCharter17())
    }
}

// MARK: - Data manipulation

extension MenuViewModelVC {
    func loadSettings() throws {
        do {
            try settings.loadSettings()
        } catch {
            throw error
        }
    }
    
    func getGameData() throws -> GameData {
        let gameDate = try storage.getGameData().first!
        
        return gameDate
    }
}
