//
//  MyStepper.swift
//  Cards
//
//  Created by macbook on 17.01.2023.
//

import UIKit

final class Stepper: UIControl {
    // MARK: Properties
    
    let increaseButton = UIButton(title: "+", titleColor: UIColor.label, backgroundColor: UIColor.clear, font: UIFont.systemFont(ofSize: 15) )
    let currentStepValueLabel = UILabel(text: "1", font: UIFont.systemFont(ofSize: 15))
    let decreaseButton = UIButton(title: "-", titleColor: UIColor.label, backgroundColor: UIColor.clear, font: UIFont.systemFont(ofSize: 15))
    
    var currentValue: Int = 2 {
        didSet {
            currentValue = currentValue >= minValue ? currentValue : minValue
            currentValue = currentValue > maxValue ? maxValue : currentValue
            currentStepValueLabel.text = "\(currentValue)"
        }
    }
    var minValue: Int = 2
    var maxValue: Int = 25
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        customizeElements()
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Actions
    
    @objc private func buttonTapped(_ sender: UIButton) {
        switch sender {
        case decreaseButton:
            currentValue -= 1
        case increaseButton:
            currentValue += 1
        default:
            break
        }
        
        sendActions(for: .valueChanged)
    }
    
    // MARK: Methods
    
    private func customizeElements() {
        // Configure increaseButton
        increaseButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        increaseButton.setTitleColor(UIColor.green, for: .highlighted)
        
        // Configure currentStepValueLabel
        currentStepValueLabel.textAlignment = .center
        
        // Configure decreaseButton
        decreaseButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        decreaseButton.setTitleColor(UIColor.red, for: .highlighted)
    }
}

// MARK: - Setup constraints

extension Stepper {
    private func setupConstraints() {
        // Create stackView for decreaseButton, currentStepValueLabel and increaseButton
        let stackView = UIStackView(arrangedSubviews: [decreaseButton, currentStepValueLabel, increaseButton], axis: .horizontal, spacing: 0)
        
        // Configure stackView
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .systemFill
        stackView.layer.cornerRadius = 5
        stackView.clipsToBounds = true

        // Adding subview
        addSubview(stackView)
        
        // Setup constraints
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
