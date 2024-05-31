//
//  TabViewController.swift
//  Vulcano
//
//  Created by Bema on 31/5/24.
//

import Foundation
import UIKit

class TabViewController: UITabBarController {
    
    // MARK: - Lyfecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
        setSelectedIndex()
        customizeTabBarAppearance()
    }
    // MARK: - Setups
    
    private func setupViewControllers() {
        let competitions = UITabBarItem(
            title: "Competitions",
            image: UIImage(systemName: "figure.2"),
            selectedImage: UIImage(systemName: "figure.2")
        )
        let competitionsFirstVC = CompetitionsFirstVC()
        competitionsFirstVC.title = competitionsFirstVC.competitionLabel.text
        competitionsFirstVC.tabBarItem = competitions
        
        let friends = UITabBarItem(
            title: "Friends",
            image: UIImage(systemName: "person.2.fill"),
            selectedImage: UIImage(systemName: "person.2.fill")
        )
        let friendsViewController = FriendsViewController()
        friendsViewController.title = "Friends"
        friendsViewController.tabBarItem = friends
        
        let notes = UITabBarItem(
            title: "Notes",
            image: UIImage(systemName: "list.bullet.circle.fill"),
            selectedImage: UIImage(systemName: "list.bullet.circle.fill")
        )
        let notesViewController = NotesVC()
        notesViewController.title = "Notes"
        notesViewController.tabBarItem = notes
        
        let settings = UITabBarItem(
            title: "Settings",
            image: UIImage(systemName: "gearshape.fill"),
            selectedImage: UIImage(systemName: "gearshape.fill")
        )
        let settingsViewController = SettingsVC()
        settingsViewController.title = "Settings"
        settingsViewController.tabBarItem = settings
        
        let controllers = [
            competitionsFirstVC,
            friendsViewController,
            notesViewController,
            settingsViewController
        ]
        viewControllers = controllers.map { UINavigationController(rootViewController: $0) }
    }
    
    private func setSelectedIndex() {
            let tabsCount = viewControllers?.count ?? 0
            if tabsCount > 2 {
                selectedIndex = tabsCount - 2
            }
        }
    
    // MARK: - Appearance
    
    private func customizeTabBarAppearance() {
        tabBar.barTintColor = .black
        tabBar.tintColor = .red
        tabBar.unselectedItemTintColor = .systemGray3
        
//        tabBar.layer.borderWidth = 1.5
//        tabBar.layer.borderColor = UIColor.black.cgColor
    }

}
