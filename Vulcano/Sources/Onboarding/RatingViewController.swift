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

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setColorBackground()
        setupUI()
        loadData()
    }


    // MARK: - Setup

    func loadData() {

    }

    private func setColorBackground() {
        view.backgroundColor = UIColor(hex: "#1A1717")
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

        view.addSubview(vulcanoImage)
        view.addSubview(nextButton)
        view.addSubview(stayLabel)

        NSLayoutConstraint.activate([
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
            let nextViewController = OnboardingSecond()
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }))
        present(alertController, animated: true, completion: nil)
    }
}

