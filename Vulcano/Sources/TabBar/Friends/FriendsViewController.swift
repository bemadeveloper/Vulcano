//
//  FriendsViewController.swift
//  Vulcano
//
//  Created by Bema on 31/5/24.
//

import Foundation
import UIKit

class FriendsViewController: UIViewController {
    
    // MARK: - Properties
    
    private var friends: [[Friend]]?
    
    
    // MARK: - UI
    
    let competitionLabel  = UILabel()
    private let addButton = UIButton()
    
    // MARK: - Table
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    // MARK: - Lyfecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setGradientBackground()
        self.setupUI()
        friends = Friend.friends
        navigationController?.navigationBar.prefersLargeTitles = true

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
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    @objc private func addButtonTapped() {
        let nextViewController = ScreenLoading()
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
}

extension FriendsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        friends?[section].count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        friends?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CustomTableViewCell
        cell?.friend = friends?[indexPath.section][indexPath.row]
        cell?.accessoryType = .detailDisclosureButton
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let viewController = DetailViewController()
//        tableView.deselectRow(at: indexPath, animated: true)
//        viewController.friend = persons?[indexPath.section][indexPath.row]
//        navigationController?.pushViewController(viewController, animated: true)
    }
}
