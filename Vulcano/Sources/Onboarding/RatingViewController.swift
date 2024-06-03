//
//  RatingViewController.swift
//  Vulcano
//
//  Created by Bema on 31/5/24.
//

import Foundation
import UIKit
import UserNotifications

class RatingViewController: UIViewController {

    // MARK: - UI

    private let vulcanoImage = UIImageView()
    private let enableButton = UIButton()
    private let stayLabel = UILabel()
    private let closeButton = UIButton()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setColorBackground()
        setupUI()
        loadData()
        //setupNavigationBar()
    }

    // MARK: - Setup

    func loadData() {

    }

    private func setColorBackground() {
        view.backgroundColor = UIColor(hex: "#1A1717")
    }

//    private func setupNavigationBar() {
//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeButtonTapped))
//    }

    private func setupUI() {
        vulcanoImage.image = UIImage(named: "IMG-6")
        vulcanoImage.translatesAutoresizingMaskIntoConstraints = false

        stayLabel.textColor = .white
        stayLabel.text = "Stay up with notifications"
        stayLabel.textAlignment = .center
        stayLabel.font = .systemFont(ofSize: 32, weight: .bold)
        stayLabel.translatesAutoresizingMaskIntoConstraints = false

        enableButton.setTitle("Enable", for: .normal)
        enableButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        enableButton.layer.cornerRadius = 15
        enableButton.backgroundColor = UIColor(hex: "#B00D22")
        enableButton.setTitleColor(.white, for: .normal)
        enableButton.translatesAutoresizingMaskIntoConstraints = false
        enableButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        
        closeButton.setImage(UIImage(systemName: "xmark.circle")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)

        view.addSubview(vulcanoImage)
        view.addSubview(enableButton)
        view.addSubview(stayLabel)
        view.addSubview(closeButton)

        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 30),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            stayLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stayLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 60),

            vulcanoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            vulcanoImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            enableButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            enableButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            enableButton.heightAnchor.constraint(equalToConstant: 50),
            enableButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85)
        ])
    }

    @objc private func nextButtonTapped() {
        requestNotificationAuthorization()
        let newViewController = CompetitionsFirstVC()
        navigationController?.pushViewController(newViewController, animated: true)
    }

    @objc private func closeButtonTapped() {
        let newViewController = CompetitionsFirstVC()
        navigationController?.pushViewController(newViewController, animated: true)
    }

    private func requestNotificationAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { [weak self] (granted, error) in
            guard granted else {
                DispatchQueue.main.async {
                    self?.showAlert(title: "Notifications Disabled", message: "You have denied notification permissions. To enable notifications, go to Settings.")
                }
                print("Notification authorization denied")
                return
            }
            DispatchQueue.main.async {
                self?.showAlert(title: "Notifications Enabled", message: "You will now receive notifications.")
            }
        }
    }

    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { _ in
            guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(settingsURL) {
                UIApplication.shared.open(settingsURL, completionHandler: { (success) in
                    print("Settings opened: \(success)")
                })
            }
        }
        
        alertController.addAction(okAction)
        alertController.addAction(settingsAction)
        
        present(alertController, animated: true, completion: nil)
    }

}

