//
//  CardTypeSelecting.swift
//  Cards
//
//  Created by macbook on 11.02.2023.
//

import UIKit

final class CardTypeSelecting: SelectTableViewViewModelType {
    // MARK: - Enumeration
    
    enum NameSpaces: String {
        case title = "Фигуры"
        case cellReuseIdentifier = "CardTypeCell"
    }
    
    // MARK: - Properties
    
    private let settings = Settings.shared
    private let cardTypes: [CardType] = [.circle, .cross, .square, .fill]
    
    var title: String { NameSpaces.title.rawValue }
    var cellReuseIdentifier: String { NameSpaces.cellReuseIdentifier.rawValue }
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
    
    func operationForSelected(cell: UITableViewCell, indexPath: IndexPath, tableView: UITableView) {
        if isCheckmark(forIndexPath: indexPath) && itemsCount > 1 {
            cell.accessoryType = .none
            removeItem(forIndexPath: indexPath)
            
        } else if !isCheckmark(forIndexPath: indexPath) {
            cell.accessoryType = .checkmark
            insertItem(forIndexPath: indexPath)
        }
    }
    
    // MARK: - Settings handle
    
    private func removeItem(forIndexPath indexPath: IndexPath) {
        settings.cardTypes.remove(textForCell(forIndexPath: indexPath))
    }
    
    private func insertItem(forIndexPath indexPath: IndexPath) {
        settings.cardTypes.insert(textForCell(forIndexPath: indexPath))
    }
    
    func saveSettings() {
        settings.saveSettings()
    }
}
