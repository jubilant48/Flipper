//
//  SelectCardTypeViewModelTVC.swift
//  Cards
//
//  Created by macbook on 11.02.2023.
//

import UIKit

final class SelectCardTypeViewModelTVC: SelectTableViewViewModelType {
    // MARK: - Enumeration
    
    enum SelectCardTypeNameSpaces: String {
        case title = "Фигуры"
        case cellReuseIdentifier = "CardTypeCell"
    }
    
    // MARK: - Properties
    
    private let settings = Settings.shared
    private let cardTypes: [CardType] = [.circle, .cross, .square, .fill]
    
    var title: String { SelectCardTypeNameSpaces.title.rawValue }
    var cellReuseIdentifier: String { SelectCardTypeNameSpaces.cellReuseIdentifier.rawValue }
    var itemsCount: Int { settings.cardTypes.count }
    
    // MARK: - Methods
    
    func numberOfRowsInSection() -> Int {
        return cardTypes.count
    }
    
    func textForCell(forIndexPath indexPath: IndexPath) -> String {
        let text = cardTypes[indexPath.row].rawValue
        
        return text
    }
    
    func isCheckmark(forIndexPath indexPath: IndexPath) -> Bool {
        let isCheckmark = settings.cardTypes.contains(textForCell(forIndexPath: indexPath))
        
        return isCheckmark
    }
    
    // MARK: - Settings handle
    
    func removeItem(forIndexPath indexPath: IndexPath) {
        settings.cardTypes.remove(textForCell(forIndexPath: indexPath))
    }
    
    func insertItem(forIndexPath indexPath: IndexPath) {
        settings.cardTypes.insert(textForCell(forIndexPath: indexPath))
    }
    
    func saveSettings() {
        settings.saveSettings()
    }
}
