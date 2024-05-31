//
//  CustomTextField.swift
//  Vulcano
//
//  Created by Bema on 29/5/24.
//

import Foundation
import UIKit

class CustomTextField: UITextField {
    
    // MARK: - UI
    
    var insets = UIEdgeInsets()
    var floatingLabel: UILabel!
    
    let color = UIColor(hex: "#101A26")

    enum CustomTextFieldType {
        case name
        case dateOfBirth
    }

    private let authFieldType: CustomTextFieldType
    
    // MARK: - Init
    
    init(fieldType: CustomTextFieldType, insets: UIEdgeInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)) {
        self.authFieldType = fieldType
        self.insets = insets
        super.init(frame: .zero)
        
        self.backgroundColor = color
        self.layer.cornerRadius = 10
        
        self.returnKeyType = .done
        self.autocorrectionType = .no
        self.autocapitalizationType = .none
        self.textColor = .white
        
        self.leftViewMode = .always
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: self.frame.size.height))
        
        setupField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setups
    
    private func setupField() {
        switch authFieldType {
        case .name:
            self.placeholder = "Enter name"
        case .dateOfBirth:
            self.placeholder = "dd.mm.yyyy"
            self.borderStyle = .roundedRect
        }
        
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(hex: "#838B91"),
            .font: UIFont.systemFont(ofSize: 15, weight: .regular)
        ]
        let attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "", attributes: placeholderAttributes)
        self.attributedPlaceholder = attributedPlaceholder
    }

}
