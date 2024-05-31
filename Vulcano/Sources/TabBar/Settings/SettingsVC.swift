//
//  SettingsVC.swift
//  Vulcano
//
//  Created by Bema on 31/5/24.
//

import Foundation
import UIKit

class SettingsVC: UIViewController {
    
    // MARK: - Properties
    
    
    // MARK: - UI
    
    private let competitionLabel  = UILabel()
    private let addButton = UIButton()
    
    
    // MARK: - Lyfecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setGradientBackground()
        self.setupUI()

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
        
    }
    
    @objc private func addButtonTapped() {
        let nextViewController = ScreenLoading()
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
}
