//
//  CustomTableViewCell.swift
//  Vulcano
//
//  Created by Bema on 1/6/24.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    // MARK: - Outlets
    
    var friend: Friend? {
        didSet {
            nameLabel.text = friend?.name
            dateLabel.text = friend?.date
        }
    }
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .white
        return label
    }()
    
    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .leading
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 1
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
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
        self.addSubview(stack)
        stack.addArrangedSubview(nameLabel)
        stack.addArrangedSubview(dateLabel)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            stack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
    }
    
    // MARK: - Reuse

    override func prepareForReuse() {
        super.prepareForReuse()
        self.accessoryType = .none
        self.friend = nil
    }
}
