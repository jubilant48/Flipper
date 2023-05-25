//
//  MenuViewViewModelType.swift
//  Cards
//
//  Created by macbook on 27.02.2023.
//

import UIKit

// MARK: - Protocol 

protocol MenuViewViewModelType: ContinueProtocol {
    // MARK: - Properties
    var backTitleButton: String { get }
    var navigationBarPrefersLargeTitles: Bool { get }
    var backgroundColor: UIColor { get }
    
    // MARK: - Methods
    
    func getGameNameLabel() -> UILabel
    func getButton(for buttonType: MenuButtonType) -> UIButton
    func getBoardGameViewController(isContinue: Bool) -> BoardGameVC
    func viewModelForSttings() -> SettingsTableViewViewModelType
    func viewModelForRecords() -> RecordsTableViewViewModelType
    func play(sound: SoundNames) throws
    
    // MARK: - Data handling
    
    func loadSettings() throws
    func getGameData() throws -> GameData
}
