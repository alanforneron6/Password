//
//  ViewController.swift
//  Password
//
//  Created by Alan Forneron on 26/07/2023.
//

import UIKit

class ViewController: UIViewController {
    let stackView = UIStackView()
    let statusView = PasswordStatusView()
    let passwordTextfield = PasswordTextField(placeHolderText: "New password")
    let confirmPasswordTextfield = PasswordTextField(placeHolderText: "Re-enter new password")
    let resetButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}

extension ViewController {
    func style() {
        statusView.translatesAutoresizingMaskIntoConstraints = false
        statusView.layer.cornerRadius = 16
        statusView.clipsToBounds = true
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        passwordTextfield.translatesAutoresizingMaskIntoConstraints = false
        confirmPasswordTextfield.translatesAutoresizingMaskIntoConstraints = false
        
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.configuration = .filled()
        resetButton.setTitle("Reset password", for: [])
        // resetButton.addTarget(self, action: #selector(resetPasswordButtonTapped), for: .primaryActionTriggered)
        
    }
    
    func layout() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(passwordTextfield)
        stackView.addArrangedSubview(statusView)
        stackView.addArrangedSubview(confirmPasswordTextfield)
        stackView.addArrangedSubview(resetButton)
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 2)
        ])
    }
}

