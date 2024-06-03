//
//  AddFriendViewController.swift
//  Vulcano
//
//  Created by Bema on 1/6/24.
//

import Foundation
import UIKit

class AddFriendViewController: UIViewController {
    
    private let headerTitle = UILabel()
    
    let dateFormatter = DateFormatter()
    private let manager = StorageManager.shared
    var friend: List?
    
    let dateField = CustomTextField(fieldType: .dateOfBirth)
    let datePicker = UIDatePicker()
    private let dateOfBirth = UILabel()
    
    let usernameField = CustomTextField(fieldType: .name)
    private let fullName = UILabel()
    

    // MARK: - Properties

    private lazy var saveButton = {
        let saveButton = UIButton(primaryAction: action)
        saveButton.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        saveButton.tintColor = .white
        saveButton.layer.cornerRadius = saveButton.frame.width / 2
        saveButton.layer.masksToBounds = true
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -5.0, bottom: 0, right: 5.0)
        return saveButton
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setGradientBackground()
        setupUI()
        setupDatePicker()
        setupHierarchy()
        setupLayout()
    }

    // MARK: - Setup

    private func setupDatePicker() {
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: true)
        
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
    
    private func setupUI() {
        
        fullName.textColor = UIColor(hex: "#B00D22")
        fullName.text = "Full name"
        fullName.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        fullName.translatesAutoresizingMaskIntoConstraints = false 
        
        dateOfBirth.textColor = UIColor(hex: "#B00D22")
        dateOfBirth.text = "Date of birth"
        dateOfBirth.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        dateOfBirth.translatesAutoresizingMaskIntoConstraints = false
        
        headerTitle.textColor = .white
        headerTitle.text = "Add new friend"
        headerTitle.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        headerTitle.translatesAutoresizingMaskIntoConstraints = false
        
        usernameField.translatesAutoresizingMaskIntoConstraints = false
        dateField.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupHierarchy() {
        view.addSubview(usernameField)
        view.addSubview(dateField)
        view.addSubview(saveButton)
        view.addSubview(headerTitle)
        
        usernameField.addSubview(fullName)
        dateField.addSubview(dateOfBirth)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            self.saveButton.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor, constant: 35),
            self.saveButton.trailingAnchor.constraint(equalTo: self.headerTitle.leadingAnchor, constant: 210),
            self.saveButton.widthAnchor.constraint(equalToConstant: 40),
            self.saveButton.heightAnchor.constraint(equalTo: self.saveButton.widthAnchor),
            
            
            self.headerTitle.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor, constant: 30),
            self.headerTitle.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.headerTitle.heightAnchor.constraint(equalToConstant: 50),


            usernameField.topAnchor.constraint(equalTo: headerTitle.bottomAnchor, constant: 30),
            usernameField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            usernameField.heightAnchor.constraint(equalToConstant: 55),
            usernameField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.85),

            dateField.topAnchor.constraint(equalTo: usernameField.bottomAnchor, constant: 30),
            dateField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            dateField.heightAnchor.constraint(equalToConstant: 55),
            dateField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.85),
            
            fullName.centerXAnchor.constraint(equalTo: usernameField.leadingAnchor, constant: 63),
            fullName.topAnchor.constraint(equalTo: usernameField.topAnchor, constant: 2),
            fullName.widthAnchor.constraint(equalToConstant: 100),
            fullName.heightAnchor.constraint(equalToConstant: 20),
            
            dateOfBirth.centerXAnchor.constraint(equalTo: dateField.leadingAnchor, constant: 68),
            dateOfBirth.topAnchor.constraint(equalTo: dateField.topAnchor, constant: 2),
            dateOfBirth.widthAnchor.constraint(equalToConstant: 100),
            dateOfBirth.heightAnchor.constraint(equalToConstant: 20)
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

    // MARK: - Actions

    @objc private func saveButtonTapped() {
        let newFriend = Friend(name: usernameField.text ?? "None", date: dateField.text ?? "None")
        Friend.addFriend(newFriend)
        navigationController?.popViewController(animated: true)
    }
    
    lazy var action = UIAction { [weak self] _ in
        guard let self = self else { return }
        
        let name = self.usernameField.text ?? ""
        
        let dateOfBirth = self.dateField.text ?? ""
        
        if self.friend == nil {
            self.manager.addNewFriend(name: name, dateOfBirth: dateOfBirth)
        } else {
            self.friend?.updateFriend(newName: name, newDate: dateOfBirth)
        }
        self.navigationController?.popViewController(animated: true)
    }
}
