//
//  CompetitionsFirstVC.swift
//  Vulcano
//
//  Created by Bema on 31/5/24.
//

import Foundation
import UIKit

class CompetitionsFirstVC: UIViewController {
    
    // MARK: - Properties
    
    
    // MARK: - UI
    
    let competitionLabel  = UILabel()
    private let addButton = UIButton()
    
    
    // MARK: - Lyfecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setGradientBackground()
        self.setupUI()
        configureCalendar()
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
        competitionLabel.textColor = .white
        competitionLabel.text = "Competitions"
        competitionLabel.textAlignment = .center
        competitionLabel.font = .systemFont(ofSize: 30, weight: .bold)
        competitionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addButton.setTitle("Add", for: .normal)
        addButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        addButton.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        addButton.tintColor = .white
        addButton.layer.cornerRadius = 10
        addButton.backgroundColor = UIColor(hex: "#B00D22")
        addButton.setTitleColor(.white, for: .normal)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        
        
        addButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5.0, bottom: 0, right: -5.0)
        addButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -5.0, bottom: 0, right: 5.0)
        
        
        view.addSubview(competitionLabel)
        view.addSubview(addButton)
        
        NSLayoutConstraint.activate([
            competitionLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            competitionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            
            addButton.leadingAnchor.constraint(equalTo: competitionLabel.trailingAnchor, constant: 70),
            addButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            addButton.heightAnchor.constraint(equalToConstant: 40),
            addButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25)
        ])
    }
    
    private func configureCalendar() {
        let calendarView = UICalendarView()
        calendarView.calendar = .current
        calendarView.locale = .current
        calendarView.fontDesign = .rounded
        calendarView.tintColor = .black
        calendarView.backgroundColor = .white
        
        calendarView.delegate = self
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(calendarView)
        
        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: competitionLabel.bottomAnchor, constant: 20),
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            calendarView.heightAnchor.constraint(equalToConstant: 400)
        ])
        
        DispatchQueue.main.async {
            let fittingSize = UIView.layoutFittingCompressedSize
            let targetSize = calendarView.systemLayoutSizeFitting(fittingSize)
            calendarView.heightAnchor.constraint(equalToConstant: targetSize.height).isActive = true
        }
        
    }
    
    @objc private func addButtonTapped() {
        let nextViewController = ScreenLoading()
        navigationController?.pushViewController(nextViewController, animated: true)
    }
}

extension CompetitionsFirstVC: UICalendarViewDelegate {
    func calendarView(_ calendarView: UICalendarView, didSelectDate date: Date, at indexPath: IndexPath) {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        let dateString = formatter.string(from: date)
        
        // Показать дату в консоли или использовать ее другим способом
        print("Selected date: \(dateString)")
        
        // Вывести дату на экран, например, в алерте
        let alertController = UIAlertController(title: "Selected Date", message: dateString, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}
    
