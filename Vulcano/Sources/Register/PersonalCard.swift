//
//  PersonalCard.swift
//  Vulcano
//
//  Created by Bema on 29/5/24.
//

import Foundation
import UIKit


class PersonalCard: UIViewController {
    
    // MARK: - UI
    
    private let headerView = AuthHeaderView(title: "Your personal card", subTitle: "Add friends and compete with them")
    
    private let finishButton = UIButton()
    
    private lazy var card: UIView = {
        let card = UIView()
        card.backgroundColor = UIColor(hex: "#B00D22")
        card.layer.cornerRadius = 6
        card.translatesAutoresizingMaskIntoConstraints = false
        
        return card
    }()
    
    private let nameLabel = UILabel()
    private let dateLabel = UILabel()
    
    var username: String?
    var date: String?
    
    // MARK: - Lines
    
    private lazy var line: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor(hex: "#B00D22")
        line.layer.cornerRadius = 3
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    private lazy var secondLine: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor(hex: "#B00D22")
        line.layer.cornerRadius = 3
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    // MARK: - Lyfecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setGradientBackground()
        self.setupUI()

        nameLabel.text = username
        dateLabel.text = date
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - Setup
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
        finishButton.setTitle("Finish", for: .normal)
        finishButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        finishButton.layer.cornerRadius = 15
        finishButton.backgroundColor = UIColor(hex: "#B00D22")
        finishButton.setTitleColor(.white, for: .normal)
        finishButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        
        self.view.addSubview(headerView)
        self.view.addSubview(card)
        
        card.addSubview(nameLabel)
        card.addSubview(dateLabel)
       
        self.view.addSubview(finishButton)
        self.view.addSubview(line)
        self.view.addSubview(secondLine)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        finishButton.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            line.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 145),
            line.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100),
            line.heightAnchor.constraint(equalToConstant: 4),
            line.widthAnchor.constraint(equalToConstant: 50),
            
            secondLine.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -145),
            secondLine.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100),
            secondLine.heightAnchor.constraint(equalToConstant: 4),
            secondLine.widthAnchor.constraint(equalToConstant: 50),
            
            self.headerView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
            self.headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.headerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.headerView.heightAnchor.constraint(equalToConstant: 270),
            
            self.card.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 30),
            self.card.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            self.card.heightAnchor.constraint(equalToConstant: 55),
            self.card.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            self.finishButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.finishButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            self.finishButton.heightAnchor.constraint(equalToConstant: 50),
            self.finishButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            nameLabel.centerXAnchor.constraint(equalTo: card.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: card.topAnchor, constant: 10),
            dateLabel.centerXAnchor.constraint(equalTo: card.centerXAnchor),
            dateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10)
        ])
    }
    
    @objc private func nextButtonTapped() {
        let nextViewController = ScreenLoading()
        navigationController?.pushViewController(nextViewController, animated: true)
    }
}
