//
//  AuthHeaderView.swift
//  Vulcano
//
//  Created by Bema on 29/5/24.
//

import Foundation
import UIKit

class AuthHeaderView: UIView {
    
    // MARK: - UI
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 34, weight: .bold)
        label.text = "Create your profile!"
        
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.text = "Let's start with your name"
        
        return label
    }()
    
    // MARK: - Lyfecycle
    
    init(title: String, subTitle: String) {
        super.init(frame: .zero)
        self.titleLabel.text = title
        self.subTitleLabel.text = subTitle
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.addSubview(titleLabel)
        self.addSubview(subTitleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor, constant: 150),
            self.titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            self.subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            self.subTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.subTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
    }
}

