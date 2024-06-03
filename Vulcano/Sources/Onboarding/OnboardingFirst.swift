//
//  OnboardingFirst.swift
//  Vulcano
//
//  Created by Bema on 29/5/24.
//

import Foundation
import UIKit

class OnboardingFirst: UIViewController {
    
    private let screenLoading = Load()
    
    // MARK: - UI
    
    private let vulcanoImage = UIImageView()
    private let nextButton = UIButton()
    
    // MARK: - Lyfecycle

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
        vulcanoImage.image = UIImage(named: "IMG-4")
        vulcanoImage.translatesAutoresizingMaskIntoConstraints = false
        
        nextButton.setTitle("Next", for: .normal)
        nextButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        nextButton.layer.cornerRadius = 15
        nextButton.backgroundColor = UIColor(hex: "#B00D22")
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        
        view.addSubview(vulcanoImage)
        view.addSubview(nextButton)
        
        NSLayoutConstraint.activate([
            vulcanoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            vulcanoImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            nextButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85)
        ])
    }
    
    @objc private func nextButtonTapped() {
        let nextViewController = OnboardingSecond()
        navigationController?.pushViewController(nextViewController, animated: true)
    }
}
