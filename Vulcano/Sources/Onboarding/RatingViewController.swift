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
    private let nextButton = UIButton()
    private let stayLabel = UILabel()
    private let closeButton = UIButton()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setColorBackground()
        setupUI()
        loadData()
        setupNavigationBar()
    }

    // MARK: - Setup

    func loadData() {

    }

    private func setColorBackground() {
        view.backgroundColor = UIColor(hex: "#1A1717")
    }

    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeButtonTapped))
    }

    private func setupUI() {
        vulcanoImage.image = UIImage(named: "IMG-6")
        vulcanoImage.translatesAutoresizingMaskIntoConstraints = false

        stayLabel.textColor = .white
        stayLabel.text = "Stay up with notifications"
        stayLabel.textAlignment = .center
        stayLabel.font = .systemFont(ofSize: 32, weight: .bold)
        stayLabel.translatesAutoresizingMaskIntoConstraints = false

        nextButton.setTitle("Enable", for: .normal)
        nextButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        nextButton.layer.cornerRadius = 15
        nextButton.backgroundColor = UIColor(hex: "#B00D22")
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        
        closeButton.setImage(UIImage(named: "xmark.circle"), for: .normal)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpOutside)

        view.addSubview(vulcanoImage)
        view.addSubview(nextButton)
        view.addSubview(stayLabel)
        view.addSubview(closeButton)

        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.topAnchor),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            stayLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stayLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 60),

            vulcanoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            vulcanoImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            nextButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85)
        ])
    }

    @objc private func nextButtonTapped() {
        requestNotificationAuthorization()
    }

    @objc private func closeButtonTapped() {
        // Handle close button action here
        dismiss(animated: true, completion: nil)
    }

    private func requestNotificationAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { [weak self] (granted, error) in
            guard granted else {
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
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            let nextViewController = TabViewController()
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }))
        present(alertController, animated: true, completion: nil)
    }
}

