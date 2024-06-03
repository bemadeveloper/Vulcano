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
    
    private let manager = StorageManager.shared
    
    // MARK: - UI
    
    let friendsLabel  = UILabel()
    private let addButton = UIButton()
    
    // MARK: - Table
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        table.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        
        return table
    }()
    
    // MARK: - Lyfecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setGradientBackground()
        setupUI()
        //navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
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
        
        addButton.setTitle("Add", for: .normal)
        addButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        addButton.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        addButton.tintColor = .white
        addButton.layer.cornerRadius = 10
        addButton.backgroundColor = UIColor(hex: "#B00D22")
        addButton.setTitleColor(.white, for: .normal)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.addTarget(self, action: #selector(addButtonTappedFor), for: .touchUpInside)
        
        addButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5.0, bottom: 0, right: -5.0)
        addButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -5.0, bottom: 0, right: 5.0)
        
        friendsLabel.textColor = .white
        friendsLabel.text = "Friends"
        friendsLabel.textAlignment = .center
        friendsLabel.font = .systemFont(ofSize: 30, weight: .bold)
        friendsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tableView)
        view.addSubview(friendsLabel)
        view.addSubview(addButton)
        
        NSLayoutConstraint.activate([
            friendsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            friendsLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            
            addButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            addButton.centerYAnchor.constraint(equalTo: friendsLabel.centerYAnchor),
            addButton.heightAnchor.constraint(equalToConstant: 40),
            addButton.widthAnchor.constraint(equalToConstant: 100),
            
            tableView.topAnchor.constraint(equalTo: friendsLabel.bottomAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .add, primaryAction: UIAction(handler: { _ in
            let addVC = AddFriendViewController()
            
            self.navigationController?.pushViewController(addVC, animated: true)
        }))
    }
    
    @objc private func addButtonTappedFor() {
        print("Add button tapped")
        let nextViewController = AddFriendViewController()
        nextViewController.modalPresentationStyle = .pageSheet
        present(nextViewController, animated: true, completion: nil)
    }
    
}

extension FriendsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        manager.friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as! CustomTableViewCell
        cell.nameLabel.text = manager.friends[indexPath.row].name
        cell.dateLabel.text = manager.friends[indexPath.row].dateOfBirth
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = AddFriendViewController()
        vc.friend = manager.friends[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let friend = manager.friends[indexPath.row]
            manager.friends.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            self.manager.friends.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            completionHandler(true)
        }
        deleteAction.image = UIImage(systemName: "trash")

        let editAction = UIContextualAction(style: .normal, title: "Edit") { (action, view, completionHandler) in
            let vc = EditFriendViewController()
            vc.friend = self.manager.friends[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
            completionHandler(true)
        }
        editAction.image = UIImage(systemName: "pencil")
        editAction.backgroundColor = .systemOrange

        let addAction = UIContextualAction(style: .normal, title: "Add") { (action, view, completionHandler) in
            let vc = AddFriendViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            completionHandler(true)
        }
        addAction.image = UIImage(systemName: "plus")

        let configuration = UISwipeActionsConfiguration(actions: [deleteAction, editAction, addAction])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
}
