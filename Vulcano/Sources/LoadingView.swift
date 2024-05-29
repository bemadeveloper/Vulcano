//
//  LoadingView.swift
//  Vulcano
//
//  Created by Bema on 29/5/24.
//

import Foundation
import UIKit

class LoadingView: UIView {
    
    var completionHandler: (() -> Void)?
    
    // MARK: - Outlets
    
    private let acitivityIndicator = UIActivityIndicatorView(style: .large)
    private let loadingIcon = UIImageView()
    private let percentageLabel = UILabel()
    
    // MARK: - Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        
    }
    
    // MARK: - Setups
    
    private func setupView() {
        setGradientBackground()
        self.layer.cornerRadius = 10
        
        acitivityIndicator.color = .white
        acitivityIndicator.translatesAutoresizingMaskIntoConstraints = false
        loadingIcon.translatesAutoresizingMaskIntoConstraints = false
        percentageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        loadingIcon.image = UIImage(named: "logos")
        
        percentageLabel.text = "0%"
        percentageLabel.textColor = .white
        percentageLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
    }
    
    private func setupHierarchy() {
        self.addSubview(acitivityIndicator)
        self.addSubview(loadingIcon)
        self.addSubview(percentageLabel)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            acitivityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -20),
            acitivityIndicator.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -80),
            
            loadingIcon.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            loadingIcon.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor, constant: -10),
            
            percentageLabel.leadingAnchor.constraint(equalTo: acitivityIndicator.trailingAnchor, constant: 10),
            percentageLabel.centerYAnchor.constraint(equalTo: acitivityIndicator.centerYAnchor)
        ])
    }
    
    private func setGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(hex: "#1C2F4E").cgColor,
            UIColor(hex: "#09172E").cgColor
        ]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.bounds
        gradientLayer.cornerRadius = self.layer.cornerRadius
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.sublayers?.first?.frame = self.bounds
    }
    
    func show(on view: UIView, completion: (() -> Void)? = nil) {
        self.frame = view.bounds
        view.addSubview(self)
        acitivityIndicator.startAnimating()
        updatePercentage(duration: 5.0)
        completionHandler = completion
    }
    
    func hide() {
        acitivityIndicator.stopAnimating()
        self.removeFromSuperview()
        completionHandler?()
    }
    
    func updatePercentage(duration: TimeInterval) {
        let totalUpdates = Int(duration / 0.1)
        var progress: Float = 0.0
        let increment = 1.0 / Float(totalUpdates)
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            progress += increment
            self.percentageLabel.text = "\(Int(progress * 100))%"
            
            if progress >= 1.0 {
                timer.invalidate()
                self.hide()
                
            }
            
        }
    }
    
}

public extension UIColor {
    convenience init(hex: String) {
        let hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        
        if hexString.hasPrefix("#") {
            scanner.currentIndex = hexString.index(after: hexString.startIndex)
        }
        
        var color: UInt64 = 0
        scanner.scanHexInt64(&color)
        
        let r = CGFloat((color & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((color & 0x00FF00) >> 8) / 255.0
        let b = CGFloat(color & 0x0000FF) / 255.0
        
        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }
}

