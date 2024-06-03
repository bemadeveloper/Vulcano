//
//  SettingsVC.swift
//  Vulcano
//
//  Created by Bema on 31/5/24.
//

import Foundation
import UIKit

class SettingsVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Properties
    
    private var settings: [[CustomSettingModel]] = [
        [CustomSettingModel(type: .usagePolicy), CustomSettingModel(type: .shareApp), CustomSettingModel(type: .rateUs)]
    ]
    
    // MARK: - UI
    
    let competitionLabel = UILabel()
    private let addButton = UIButton()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(CellSetting.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = UIColor(hex: "#101A26")
        tableView.layer.cornerRadius = 10
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Lyfecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setGradientBackground()
        setupUI()
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: competitionLabel.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // MARK: - TableView DataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CellSetting
        let setting = settings[indexPath.section][indexPath.row]
        cell?.configure(with: setting)
        return cell ?? UITableViewCell()
    }
    
    // MARK: - TableView Delegate
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
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
        competitionLabel.textColor = .white
        competitionLabel.text = "Settings"
        competitionLabel.textAlignment = .center
        competitionLabel.font = .systemFont(ofSize: 30, weight: .bold)
        competitionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(competitionLabel)
        
        NSLayoutConstraint.activate([
            competitionLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            competitionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
        ])
    }
    
    @objc private func addButtonTapped() {
        let nextViewController = ScreenLoading()
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
}
