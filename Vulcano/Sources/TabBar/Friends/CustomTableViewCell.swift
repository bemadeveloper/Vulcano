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
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .leading
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 1
        return stack
    }()
    
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupHierarchy() {
        stack.addArrangedSubview(nameLabel)
        stack.addArrangedSubview(dateLabel)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            
        ])
    }
    
    // MARK: - Reuse

    override func prepareForReuse() {
        super.prepareForReuse()
        self.accessoryType = .none
        self.friend = nil
    }
}
