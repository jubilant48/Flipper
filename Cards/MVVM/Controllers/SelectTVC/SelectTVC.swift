//
//  SelectCardTypeTVC.swift
//  Cards
//
//  Created by macbook on 21.01.2023.
//

import UIKit

final class SelectTVC: UITableViewController {
    // MARK: Properties
    
    private var viewModel: SelectTableViewViewModelType!
    
    // MARK: Init
    
    init(viewModel: SelectTableViewViewModelType) {
        super.init(style: .insetGrouped)
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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: viewModel.cellReuseIdentifier)
    }
    
    // MARK: Actions
    
    @objc private func backButtonTapped() {
        viewModel.saveSettings()
        
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: Update UI
    
    private func setLeftBarButton() {
        self.navigationItem.leftBarButtonItem?.target = self
        self.navigationItem.leftBarButtonItem?.action = #selector(backButtonTapped)
    }
    
    private func setNavigationItem() {
        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationItem.title = viewModel.title
        setLeftBarButton()
    }
    
    private func updateUI() {
        setNavigationItem()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.cellReuseIdentifier, for: indexPath)
        
        if viewModel.isCheckmark(forIndexPath: indexPath) {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        var configuration = cell.defaultContentConfiguration()
        configuration.text = viewModel.textForCell(forIndexPath: indexPath)
        
        cell.contentConfiguration = configuration
        
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        
        viewModel.operationForSelected(cell: cell, indexPath: indexPath, tableView: tableView)
        
        tableView.reloadData()
    }
}
