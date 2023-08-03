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
    let newPasswordTextField = PasswordTextField(placeHolderText: "New password")
    let confirmPasswordTextField = PasswordTextField(placeHolderText: "Re-enter new password")
    let resetButton = UIButton(type: .system)
    typealias CustomValidation = PasswordTextField.CustomValidation
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        style()
        layout()
    }
}

extension ViewController {
    private func setup() {
        setupDismissKeyboardGesture()
        setupNewPassword()
        setupConfirmPassword()
    }
    
    private func setupNewPassword() {
        let newPasswordValidation: CustomValidation = { text in
            guard let text = text, !text.isEmpty else {
                self.statusView.reset()
                return (false, "Enter your password")
            }
            // Valid characters
            let validChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,@:?!()$\\/#"
            let invalidSet = CharacterSet(charactersIn: validChars).inverted
            guard text.rangeOfCharacter(from: invalidSet) == nil else {
                self.statusView.reset()
                return (false, "Enter valid special chars (.,@:?!()$\\/#) with no spaces")
            }
            self.statusView.updateDisplay(text)
            if !self.statusView.validate(text) {
                return (false, "Your password must meet the requirements below")
            }
            return (true, "")
        }
        
        newPasswordTextField.customValidation = newPasswordValidation
        newPasswordTextField.delegate = self
    }

    private func setupConfirmPassword() {
        let confirmPasswordValidation: CustomValidation = { text in
            guard let text = text, !text.isEmpty else {
                return (false, "Enter your password.")
            }

            guard text == self.newPasswordTextField.text else {
                return (false, "Passwords do not match.")
            }

            return (true, "")
        }
        confirmPasswordTextField.customValidation = confirmPasswordValidation
        confirmPasswordTextField.delegate = self
    }

    private func setupDismissKeyboardGesture() {
        let dismissKeyboardTap = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_: )))
        view.addGestureRecognizer(dismissKeyboardTap)
    }
    
    @objc func viewTapped(_ recognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    func style() {
        statusView.translatesAutoresizingMaskIntoConstraints = false
        statusView.layer.cornerRadius = 16
        statusView.clipsToBounds = true
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        newPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        confirmPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.configuration = .filled()
        resetButton.setTitle("Reset password", for: [])
        // resetButton.addTarget(self, action: #selector(resetPasswordButtonTapped), for: .primaryActionTriggered)
        
    }
    
    func layout() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(newPasswordTextField)
        stackView.addArrangedSubview(statusView)
        stackView.addArrangedSubview(confirmPasswordTextField)
        stackView.addArrangedSubview(resetButton)
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 2)
        ])
    }
}

extension ViewController: PasswordTextFieldDelegate {
    func editingChanged(_ sender: PasswordTextField) {
        if sender === newPasswordTextField {
            statusView.updateDisplay(sender.textField.text ?? "")
        }
    }
    
    func editingDidEnd(_ sender: PasswordTextField) {
        if sender === newPasswordTextField {
            statusView.shouldResetCriteria = false
            _ = newPasswordTextField.validate()
        } else if sender == confirmPasswordTextField {
            _ = confirmPasswordTextField.validate()
        }
        
    }
    
}
