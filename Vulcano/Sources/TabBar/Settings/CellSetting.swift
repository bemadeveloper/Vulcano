//
//  CellSetting.swift
//  Vulcano
//
//  Created by Bema on 1/6/24.
//

import Foundation
import UIKit

class CellSetting: UITableViewCell {
    // MARK: - Properties
    
    private let settingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let settingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupHierarchy()
        setupLayout()
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupCell() {
        self.backgroundColor = UIColor(hex: "#B00D22")
        self.layer.cornerRadius = 20
        self.layer.masksToBounds = true
    }
    
    private func setupHierarchy() {
        addSubview(settingImageView)
        addSubview(settingLabel)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            settingImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            settingImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            settingImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            settingImageView.widthAnchor.constraint(equalToConstant: 40),
            
            settingLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            settingLabel.leadingAnchor.constraint(equalTo: settingImageView.trailingAnchor, constant: 10),
            settingLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
    
    // MARK: - Configure
    
    func configure(with setting: CustomSettingModel) {
        settingImageView.image = setting.type.image
        settingLabel.text = setting.type.rawValue
    }
}
