//
//  SettingsTVC.swift
//  Cards
//
//  Created by macbook on 17.01.2023.
//

import UIKit

final class SettingsTVC: UITableViewController {
    // MARK: Properties
    
    private var viewModel: SettingsTableViewViewModelType!
    
    // MARK: Init
    
    init(style: UITableView.Style, viewModel: SettingsTableViewViewModelType) {
        super.init(style: style)
        
        self.viewModel = viewModel
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
        viewModel.registerTableViewCell(tableView: tableView)
    }
    
    // MARK: Actions
    
    @objc private func saveButtonTapped() {
        viewModel.saveSettings(forTableView: tableView)
        
        // Dissmiss SettingsTableViewController
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: Update UI
    
    private func createSaveButton() {
        let saveButton = UIBarButtonItem(title: viewModel.saveButtonTitle, style: .done, target: self, action: #selector(saveButtonTapped))
        
        self.navigationItem.rightBarButtonItem = saveButton
    }
    
    private func updateUI() {
        self.navigationItem.title = viewModel.title
        createSaveButton()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSection()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRows: Int = 0
        
        do {
            numberOfRows = try viewModel.numberOfRows(inSection: section)
        } catch {
            self.showErrorAlert(description: error.localizedDescription)
        }
        
        return numberOfRows
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell = UITableViewCell()
        
        switch indexPath {
        case viewModel.numberPairsCardsIndexPath:
            let labelAndStepperCell = tableView.dequeueReusableCell(withIdentifier: LabelAndStepperCell.identifier, for: indexPath) as! LabelAndStepperCell
            
            labelAndStepperCell.viewModel = viewModel.viewModelCell(forIndexPath: indexPath)
            
            cell = labelAndStepperCell
        case viewModel.isShowReverseCardsButtonIndexPath:
            let labelAndSwitchCell = tableView.dequeueReusableCell(withIdentifier: LabelAndSwitchCell.identifier, for: indexPath) as! LabelAndSwitchCell
            
            labelAndSwitchCell.viewModel = viewModel.viewModelCell(forIndexPath: indexPath)
            
            cell = labelAndSwitchCell
        default:
            let settingsCell = tableView.dequeueReusableCell(withIdentifier: SettingsTVCell.identifier, for: indexPath) as! SettingsTVCell
            
            settingsCell.accessoryType = .disclosureIndicator
            settingsCell.viewModel = viewModel.viewModelCell(forIndexPath: indexPath)
            
            cell = settingsCell
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.header(for: section)
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return viewModel.footer(for: section)
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let viewModelForRow = viewModel.viewModel(forIndexPath: indexPath) {
            navigationController?.pushViewController(SelectTVC(viewModel: viewModelForRow), animated: true)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
