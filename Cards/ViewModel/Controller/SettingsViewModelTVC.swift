//
//  SettingsViewModelTVC.swift
//  Cards
//
//  Created by macbook on 21.01.2023.
//

import UIKit

final class SettingsViewModelTVC: SettingsTableViewViewModelType {
    // MARK: - Enumeration
    
    enum SettingsNameSpaces: String {
        case title = "Настройки"
        case saveButtonTitle = "Сохранить"
    }
    
    // MARK:  - Properties
    
    typealias Section = Int
    typealias NumberOfRows = Int
    
    let numberPairsCardsIndexPath: IndexPath = IndexPath(row: 0, section: 0)
    let isShowReverseCardsButtonIndexPath: IndexPath = IndexPath(row: 1, section: 0)
    
    private let cardsTypesIndexPath: IndexPath = IndexPath(row: 0, section: 1)
    private let cardsColorIndexPath: IndexPath = IndexPath(row: 1, section: 1)
    private let backTypeIndexPath: IndexPath = IndexPath(row: 2, section: 1)
    
    private let settings: Settings = Settings.shared
    private var settingsTable: [Section: [IndexPath]] {
        let settingsTable = [
            0 : [numberPairsCardsIndexPath, isShowReverseCardsButtonIndexPath],
            1 : [backTypeIndexPath, cardsColorIndexPath, backTypeIndexPath]
        ]
        
        return settingsTable
    }

    var title: String { SettingsNameSpaces.title.rawValue }
    var saveButtonTitle: String { SettingsNameSpaces.saveButtonTitle.rawValue }
    
    // MARK: - Methods
    
    func numberOfSection() -> Int {
        return settingsTable.count
    }
    
    func numberOfRows(inSection section: Int) throws -> Int {
        guard let numberOfRows = settingsTable[section]?.count else {
            throw SettingsViewModelError.sectionNotExist
        }
        
        return numberOfRows
    }
    
    func registerTableViewCell(tableView: UITableView) {
        tableView.register(SettingsTVCell.self, forCellReuseIdentifier: SettingsTVCell.identifier)
        tableView.register(LabelAndStepperCell.self, forCellReuseIdentifier: LabelAndStepperCell.identifier)
        tableView.register(LabelAndSwitchCell.self, forCellReuseIdentifier: LabelAndSwitchCell.identifier)
    }
    
    func viewModelCell<T>(forIndexPath indexPath: IndexPath) -> T {
        var viewModel: T
        
        switch indexPath {
        case numberPairsCardsIndexPath:
            viewModel = LabelAndStepperViewModelCell() as! T
        case isShowReverseCardsButtonIndexPath:
            viewModel = LabelAndSwitchViewModelCell() as! T
        default:
            viewModel = SettingsTVViewModelCell(indexPath: indexPath) as! T
        }
        
        return viewModel
    }
    
    func viewModel(forIndexPath indexPath: IndexPath) -> SelectTableViewViewModelType? {
        var viewModel: SelectTableViewViewModelType?
        
        switch indexPath {
        case cardsTypesIndexPath:
            viewModel = SelectCardTypeViewModelTVC()
        case cardsColorIndexPath:
            viewModel = SelectCardColorViewModelTVC()
        case backTypeIndexPath:
            viewModel = SelectCardBackViewModelTVC()
        default:
            break
        }
        
        return viewModel
    }
    
    func header(for section: Int) -> String? {
        switch section {
        case numberPairsCardsIndexPath.section:
            return "Настройки игрового процесса"
        case cardsTypesIndexPath.section:
            return "Настройки оформления"
        default:
            return nil
        }
    }
    
    func footer(for section: Int) -> String? {
        switch section {
        case isShowReverseCardsButtonIndexPath.section:
            return "Режим просмотра карт, позволяет с помощью кнопки переворачивать карты для их просмотра. При этом отключая режим записи рекордов."
        default:
            return nil
        }
    }
}

// MARK: - Storage methods

extension SettingsViewModelTVC {
    func saveSettings(forTableView tableView: UITableView) {
        // Setup cardPairsCount
        let cardsParisCountsCell = tableView.cellForRow(at: numberPairsCardsIndexPath) as! LabelAndStepperCell
        
        // Setup isShowReverseCardButtonCell
        let isShowReverseCardsButtonCell = tableView.cellForRow(at: isShowReverseCardsButtonIndexPath) as! LabelAndSwitchCell
        
        settings.numberPairsCards = cardsParisCountsCell.stepper.currentValue
        settings.isShowReverseCardsButton = isShowReverseCardsButtonCell.switchView.isOn
        
        settings.saveSettings()
    }
}
