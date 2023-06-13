//
//  CardBackSelecting.swift
//  Cards
//
//  Created by macbook on 11.02.2023.
//

import UIKit

final class CardBackSelecting: SelectTableViewViewModelType {
    // MARK:  - Enumeration
    
    enum NameSpaces: String {
        case title = "Рубашки"
        case cellReuseIdentifier = "BackSideCardCell"
    }
    
    // MARK: - Properties
    
    private let settings = Settings.shared
    private let cardBackSides: [CardBackSide] = [.circle, .line]
    
    var title: String { NameSpaces.title.rawValue }
    var cellReuseIdentifier: String { NameSpaces.cellReuseIdentifier.rawValue }
    var itemsCount: Int { settings.cardBackSides.count }
    
    // MARK: - Methods
    
    func numberOfRowsInSection() -> Int {
        return cardBackSides.count
    }
    
    func textForCell(forIndexPath indexPath: IndexPath) -> String {
        let text = cardBackSides[indexPath.row].rawValue
        
        return text
    }
    
    func isCheckmark(forIndexPath indexPath: IndexPath) -> Bool {
        let isCheckmark = settings.cardBackSides.contains(textForCell(forIndexPath: indexPath))
        
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
        settings.cardBackSides.remove(textForCell(forIndexPath: indexPath))
    }
    
    private func insertItem(forIndexPath indexPath: IndexPath) {
        settings.cardBackSides.insert(textForCell(forIndexPath: indexPath))
    }
    
    func saveSettings() {
        settings.saveSettings()
    }
}
