//
//  SettingsTableViewViewModelType.swift
//  Cards
//
//  Created by macbook on 17.02.2023.
//

import UIKit

// MARK: - Protocol

protocol SettingsTableViewViewModelType {
    // MARK: - Properties
    
    var numberPairsCardsIndexPath: IndexPath { get }
    var isShowReverseCardsButtonIndexPath: IndexPath { get }
    
    var title: String { get }
    var saveButtonTitle: String { get }
    
    // MARK: - Methods
    
    func registerTableViewCell(tableView: UITableView)
    func numberOfSection() -> Int
    func numberOfRows(inSection section: Int) throws -> Int
    func viewModelCell<T>(forIndexPath indexPath: IndexPath) -> T
    func viewModel(forIndexPath indexPath: IndexPath) -> SelectTableViewViewModelType?
    func header(for section: Int) -> String?
    func footer(for section: Int) -> String?
    
    // MARK: - Data handling
    
    func saveSettings(forTableView tableView: UITableView)
}
