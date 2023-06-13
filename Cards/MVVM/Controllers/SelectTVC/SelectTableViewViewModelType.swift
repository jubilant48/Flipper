//
//  TableViewModelType.swift
//  Cards
//
//  Created by macbook on 11.02.2023.
//

import UIKit

// MARK: - Protocol

protocol SelectTableViewViewModelType {
    // MARK: - Properties
    
    var title: String { get }
    var cellReuseIdentifier: String { get }
    var itemsCount: Int { get }
    
    // MARK: - Methods
    func numberOfRowsInSection() -> Int
    func textForCell(forIndexPath indexPath: IndexPath) -> String
    func isCheckmark(forIndexPath indexPath: IndexPath) -> Bool
    func operationForSelected(cell: UITableViewCell, indexPath: IndexPath, tableView: UITableView)
    
//    func removeItem(forIndexPath indexPath: IndexPath)
//    func insertItem(forIndexPath indexPath: IndexPath)
    
    // MARK: - Data handling
    
    func saveSettings()
}
