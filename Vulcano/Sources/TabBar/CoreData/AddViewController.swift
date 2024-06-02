//
//  AddViewController.swift
//  Vulcano
//
//  Created by Bema on 2/6/24.
//

import Foundation
import UIKit

class AddViewController: UIViewController {
    
    let dateFormatter = DateFormatter()
    private let manager = StorageManager.shared
    var friend: List?
    let datePicker = UIDatePicker()
    
    lazy var nameField: UITextField = {
        let name = UITextField()
        name.placeholder = "name"
        name.translatesAutoresizingMaskIntoConstraints = false
        name.heightAnchor.constraint(equalToConstant: 50).isActive = true
        name.backgroundColor = .gray
        
        
        return name
    }()
    
    let dateField = CustomTextField(fieldType: .dateOfBirth)
    
    lazy var oldField: UITextField = {
        let name = UITextField()
        name.placeholder = "old"
        name.translatesAutoresizingMaskIntoConstraints = false
        name.heightAnchor.constraint(equalToConstant: 50).isActive = true
        name.backgroundColor = .gray
        
        
        return name
    }()
    
    lazy var btn: UIButton = {
        let btn = UIButton(primaryAction: action)
        btn.setTitle("save", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        return btn
    }()
    
    lazy var action = UIAction { [weak self] _ in
        guard let self = self else { return }
        
        // Получаем значения из текстовых полей
        let name = self.nameField.text ?? ""
        let old = self.oldField.text ?? ""
        
        let dateOfBirth = self.dateField.text ?? ""
        
        // Создание уникального идентификатора, если у вас нет другого способа его получения
        
        if self.friend == nil {
            // Вызов метода createFriend
            self.manager.createFriend(name: name, dateOfBirth: dateOfBirth, old: old)
        } else {
            self.manager.updateFriend(newName: name, newData: dateOfBirth)
        }
        self.navigationController?.popViewController(animated: true)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDatePicker()
        dateField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameField)
        view.addSubview(dateField)
        view.addSubview(oldField)
        view.addSubview(btn)
        
        title = "Add"
        
        NSLayoutConstraint.activate([
            nameField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                 nameField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                 nameField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                 nameField.heightAnchor.constraint(equalToConstant: 50),
                 
                 // Констрейнты для dateField
                 dateField.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 20),
                 dateField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                 dateField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                 dateField.heightAnchor.constraint(equalToConstant: 50),
                 
                 // Констрейнты для oldField
                 oldField.topAnchor.constraint(equalTo: dateField.bottomAnchor, constant: 20),
                 oldField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                 oldField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                 oldField.heightAnchor.constraint(equalToConstant: 50),
                 
                 // Констрейнты для btn
                 btn.topAnchor.constraint(equalTo: oldField.bottomAnchor, constant: 20),
                 btn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                 btn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                 btn.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
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
}
