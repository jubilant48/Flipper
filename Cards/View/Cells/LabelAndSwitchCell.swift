//
//  LabelAndSwitchCell.swift
//  Cards
//
//  Created by macbook on 21.01.2023.
//

import UIKit

// MARK: - Classes

final class LabelAndSwitchCell: UITableViewCell {
    // MARK: Properties
    
    static let identifier = "labelAndSwitchCell"
    
    let label = UILabel(text: "", font: UIFont.systemFont(ofSize: 17))
    let switchView = UISwitch()
    
    var viewModel: LabelAndSwitchCellViewModelType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            
            label.text = viewModel.title
            switchView.isOn = viewModel.isOn
        }
    }
    
    // MARK: Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        customizeElement()
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

// MARK: - Setup elements

extension LabelAndSwitchCell {
    private func customizeElement() {
        // Configure label
        label.translatesAutoresizingMaskIntoConstraints = false
        
        // Configure switchvView
        switchView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        // Adding subview
        contentView.addSubview(label)
        contentView.addSubview(switchView)
        
        // Setup constraints
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 7),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -7),
        ])
        
        NSLayoutConstraint.activate([
            switchView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 7),
            switchView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            switchView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -7),
        ])
    }
}
