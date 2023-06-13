//
//  SettingsTVViewModelCell.swift
//  Cards
//
//  Created by macbook on 17.02.2023.
//

import UIKit

final class SettingsTVViewModelCell: SettingsTableViewCellViewModelType {
    // MARK: - Enumertion
    
    enum TitleSpaces: String {
        case cardsTypes = "Фигуры"
        case cardsColors = "Цвета фигур"
        case cardsBacks = "Рубашки"
        case animations = "Анимации"
    }
    
    // MARK: - Properties
    
    private let cardsTypesIndexPath: IndexPath = IndexPath(row: 0, section: 1)
    private let cardsColorIndexPath: IndexPath = IndexPath(row: 1, section: 1)
    private let backTypeIndexPath: IndexPath = IndexPath(row: 2, section: 1)
    private let animationsBoardIndexPath: IndexPath = IndexPath(row: 0, section: 2)
    
    var indexPath: IndexPath
    
    var title: String {
        var title: String = ""
        
        switch indexPath {
        case cardsTypesIndexPath:
            title = TitleSpaces.cardsTypes.rawValue
        case cardsColorIndexPath:
            title = TitleSpaces.cardsColors.rawValue
        case backTypeIndexPath:
            title = TitleSpaces.cardsBacks.rawValue
        case animationsBoardIndexPath:
            title = TitleSpaces.animations.rawValue
        default:
            break
        }
        
        return title
    }
    
    // MARK: - Init
    
    init(indexPath: IndexPath) {
        self.indexPath = indexPath
    }
}
