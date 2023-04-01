//
//  MenuVC.swift
//  Cards
//
//  Created by macbook on 09.01.2023.
//

import UIKit

final class MenuVC: UIViewController {
    // MARK: - Properties
    
    private var viewModel: MenuViewViewModelType!
    
    private lazy var gameNameLabel: UILabel = viewModel.getGameNameLabel()
    private lazy var continueButton: UIButton = viewModel.getButton(for: .continueType)
    private lazy var startNewGameButton: UIButton = viewModel.getButton(for: .start)
    private lazy var settingsButton: UIButton = viewModel.getButton(for: .settings)
    private lazy var recordsButton: UIButton = viewModel.getButton(for: .record)
    private lazy var exitButton: UIButton =  viewModel.getButton(for: .exit)
    
    // MARK: - Life Cycle
    
    override func loadView() {
        super.loadView()
        
        viewModel = MenuViewModelVC()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = viewModel.backgroundColor
        
        customizeNavigation()
        customizeElement()
        setupConstraints()
        
        do {
            try viewModel.loadSettings()
        } catch {
            showErrorAlert(description: error.localizedDescription)
        }
    }
    
    // MARK: - Actions
    
    @objc private func continueButtonTapped() {
        do {
            try viewModel.play(sound: .click)
            
            let gameData = try viewModel.getGameData()
            let boardGameController = viewModel.getBoardGameViewController(isContinue: true)
            
            do {
                try viewModel.setGameDataFor(boardGameController, gameData: gameData)
            } catch {
                showErrorAlert(description: error.localizedDescription)
            }
            
            self.present(boardGameController, animated: true)
        } catch {
            self.showErrorAlert(description: error.localizedDescription)
        }
    }
    
    @objc private func startNewGameButtonTapped() {
        do {
            try viewModel.play(sound: .click)
        } catch {
            self.showErrorAlert(description: error.localizedDescription)
        }
        
        let boardGameController = viewModel.getBoardGameViewController(isContinue: false)
        
        self.present(boardGameController, animated: true)
    }
    
    @objc private func settingsButtonTapped() {
        do {
            try viewModel.play(sound: .click)
        } catch {
            self.showErrorAlert(description: error.localizedDescription)
        }
        
        let viewModel = viewModel.viewModelForSttings()
        
        navigationController?.pushViewController(SettingsTVC(style: .insetGrouped, viewModel: viewModel), animated: true)
    }
    
    @objc private func exitButtonTapped() {
        do {
            try viewModel.play(sound: .click)
        } catch {
            self.showErrorAlert(description: error.localizedDescription)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
        }
    }
    
    // MARK: - Methods
    
    private func customizeNavigation() {
        navigationItem.backButtonTitle = viewModel.backTitleButton
        navigationController?.navigationBar.prefersLargeTitles = viewModel.navigationBarPrefersLargeTitles
    }
    
    private func customizeElement() {
        // Configure continueButton
        continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        
        // Configure startNewGameButton
        startNewGameButton.addTarget(self, action: #selector(startNewGameButtonTapped), for: .touchUpInside)
        
        // Configure setiingsButton
        settingsButton.addTarget(self, action: #selector(settingsButtonTapped), for: .touchUpInside)
        
        // Configure exitButton
        exitButton.addTarget(self, action: #selector(exitButtonTapped), for: .touchUpInside)
    }
}

// MARK: - Setup constraints

extension MenuVC {
    private func setupConstraints() {
        // Create buttonsStackView
        let buttonsStackView = UIStackView(arrangedSubviews: [continueButton, startNewGameButton, settingsButton, recordsButton, exitButton], axis: .vertical, spacing: 35)
        
        // Configure buttonsStackView
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonsStackView.distribution = .fillEqually
        
        // Adding subview
        view.addSubview(gameNameLabel)
        view.addSubview(buttonsStackView)
        
        // Setup constraints
        NSLayoutConstraint.activate([
            gameNameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            gameNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 55),
            gameNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -55),
            gameNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gameNameLabel.heightAnchor.constraint(equalToConstant: 65)
        ])
        
        NSLayoutConstraint.activate([
            buttonsStackView.topAnchor.constraint(equalTo: gameNameLabel.bottomAnchor, constant: 100),
            buttonsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 55),
            buttonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -55),
            buttonsStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200)
        ])
    }
}
