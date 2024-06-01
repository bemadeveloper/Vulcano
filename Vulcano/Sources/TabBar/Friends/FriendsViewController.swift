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
    
    let friendsLabel  = UILabel()
    private let addButton = UIButton()
    
    // MARK: - Table
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = .clear
        tableView.backgroundView = nil
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
        friends = Friend.friends
        //navigationController?.navigationBar.prefersLargeTitles = true

    }
    
    override func viewWillAppear(_ animated: Bool) {
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
        print("h")
        print(addButton.frame)
        DispatchQueue.main.async {
            print("friendsLabel frame: \(self.friendsLabel.frame)")
            print("addButton frame: \(self.addButton.frame)")
            print("tableView frame: \(self.tableView.frame)")
        }
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

    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { (action, view, completionHandler) in
            self.friends?[indexPath.section].remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            completionHandler(true)
        }
        deleteAction.image = UIImage(systemName: "trash.fill")
        deleteAction.backgroundColor = UIColor(hex: "#B00D22")
        
        let editAction = UIContextualAction(style: .normal, title: nil) { (action, view, completionHandler) in
            let friend = self.friends?[indexPath.section][indexPath.row]
            
            let editFriendViewController = EditFriendViewController()
            editFriendViewController.friend = friend
            
            editFriendViewController.completionHandler = { editedFriend in
            
                self.friends?[indexPath.section][indexPath.row] = editedFriend
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
            self.present(editFriendViewController, animated: true, completion: nil)
            
            completionHandler(true)
        }
        editAction.image = UIImage(systemName: "pencil")
        editAction.backgroundColor = .systemOrange
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
        return configuration
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // Этот метод вызывается, когда пользователь совершает свайп
        // Если вы уже реализовали удаление ячейки в методе trailingSwipeActionsConfigurationForRowAt, этот метод можно оставить пустым
    }
}
