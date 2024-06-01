//
//  AddFriendViewController.swift
//  Vulcano
//
//  Created by Bema on 1/6/24.
//

import Foundation
import UIKit

class AddFriendViewController: UIViewController {
    
    let dateField = CustomTextField(fieldType: .dateOfBirth)
    let datePicker = UIDatePicker()
    private let dateOfBirth = UILabel()
    
    let usernameField = CustomTextField(fieldType: .name)
    private let fullName = UILabel()

    // MARK: - Properties

    private let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setGradientBackground()
        setupHierarchy()
        setupLayout()
    }

    // MARK: - Setup

    private func setupDatePicker() {
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        
        // Create toolbar with "Done" button
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: true)
        
        // Assign datePicker and toolbar to inputView and inputAccessoryView of the dateField
        dateField.inputView = datePicker
        dateField.inputAccessoryView = toolbar
    }
    
    @objc func dateChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateField.text = dateFormatter.string(from: sender.date)
    }
    
    @objc func donePressed() {
        dateField.resignFirstResponder()
    }
    
    private func setupHierarchy() {
        view.addSubview(usernameField)
        view.addSubview(dateField)
        view.addSubview(saveButton)
        
        usernameField.addSubview(fullName)
        dateField.addSubview(dateOfBirth)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            usernameField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            usernameField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            usernameField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            dateField.topAnchor.constraint(equalTo: usernameField.bottomAnchor, constant: 20),
            dateField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            dateField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func setGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(hex: "#1C2F4E").cgColor,
            UIColor(hex: "#09172E").cgColor
        ]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = view.bounds
        gradientLayer.cornerRadius = view.layer.cornerRadius
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    
    private func setupUI() {
        
    }

    // MARK: - Actions

    @objc private func saveButtonTapped() {
        // Implement saving logic here
        navigationController?.popViewController(animated: true)
    }
}
