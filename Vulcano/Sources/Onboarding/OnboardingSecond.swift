//
//  OnboardingSecond.swift
//  Vulcano
//
//  Created by Bema on 30/5/24.
//

import Foundation
import UIKit
import UserNotifications
import StoreKit

class OnboardingSecond: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let windowScene = view.window?.windowScene {
            SKStoreReviewController.requestReview(in: windowScene)
            
        }
    }
    
    // MARK: - UI
    
    private let rateImage = UIImageView()
    private let nextButton = UIButton()
    private let rateUsLabel = UILabel()
    
    // MARK: - Lyfecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setColorBackground()
        setupUI()
        
    }
    
    
    // MARK: - Setup
    private func setColorBackground() {
        view.backgroundColor = UIColor(hex: "#1A1717")
    }
    
    private func setupUI() {
        rateImage.image = UIImage(named: "IMG-5")
        rateImage.translatesAutoresizingMaskIntoConstraints = false
        
        nextButton.setTitle("Next", for: .normal)
        nextButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        nextButton.layer.cornerRadius = 15
        nextButton.backgroundColor = UIColor(hex: "#B00D22")
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        
        rateUsLabel.textColor = .white
        rateUsLabel.text = "Rate us at App Store"
        rateUsLabel.textAlignment = .center
        rateUsLabel.font = .systemFont(ofSize: 32, weight: .bold)
        rateUsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(rateImage)
        view.addSubview(nextButton)
        view.addSubview(rateUsLabel)
        
        NSLayoutConstraint.activate([
            rateUsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            rateUsLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 60),
            
            rateImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            rateImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            nextButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85)
        ])
    }
    
    @objc private func showRating() {
        let ratingViewController = RatingViewController()
        ratingViewController.modalPresentationStyle = .overFullScreen
        ratingViewController.modalTransitionStyle = .crossDissolve
        present(ratingViewController, animated: true, completion: nil)
    }
    
    @objc private func nextButtonTapped() {
        let nextViewController = RatingViewController()
        navigationController?.pushViewController(nextViewController, animated: true)
    }
}
