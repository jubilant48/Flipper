//
//  CardsParisCountsCell.swift
//  Cards
//
//  Created by macbook on 17.01.2023.
//

import UIKit

// MARK: - Classes

final class LabelAndStepperCell: UITableViewCell {
    // MARK: Properties
    
    static let identifier = "labelAndStepperCell"
    
    var label = UILabel(text: "", font: UIFont.systemFont(ofSize: 17))
    let stepper = Stepper()
    
    var viewModel: LabelAndStepperCellViewModelType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            
            label.text = viewModel.title
            stepper.currentValue = viewModel.currentValue
        }
    }

    // MARK: Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        customizeElements()
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

extension LabelAndStepperCell {
    private func customizeElements() {
        // Configure label
        label.translatesAutoresizingMaskIntoConstraints = false
        
        // Configure stepper
        stepper.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        // Adding subview
        contentView.addSubview(label)
        contentView.addSubview(stepper)
        
        // Setup constraints
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 7),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -7)
        ])
        
        NSLayoutConstraint.activate([
            stepper.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 7),
            stepper.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            stepper.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -7),
            stepper.heightAnchor.constraint(equalToConstant: 32),
            stepper.widthAnchor.constraint(equalToConstant: 132)
        ])
    }
}
