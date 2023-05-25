//
//  RecordsTVC.swift
//  Cards
//
//  Created by macbook on 17.04.2023.
//

import UIKit

final class RecordsTVC: UITableViewController {
    // MARK: Properties
    
    private var viewModel: RecordsTableViewViewModelType!
    
    // MARK: Init
    
    init(viewModel: RecordsTableViewViewModelType!) {
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
        
        navigationItem.title = viewModel.title
        navigationItem.largeTitleDisplayMode = viewModel.largeTitleDisplayMode
        navigationItem.backButtonTitle = viewModel.backButtonTitle
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: viewModel.cellReuseIdentifier)
        tableView.register(RecordCell.self, forCellReuseIdentifier: viewModel.cellReuseIdentifier)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.getCell(for: tableView, indexPath: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.header(for: section)
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return viewModel.footer(for: section)
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let viewModel = viewModel.getViewModel(for: viewModel.items[indexPath.row]) else { return }
        
        navigationController?.pushViewController(RecordsTVC(viewModel: viewModel), animated: true)
    }
}
