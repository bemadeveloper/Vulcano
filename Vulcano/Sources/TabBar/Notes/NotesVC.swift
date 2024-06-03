//
//  NotesVC.swift
//  Vulcano
//
//  Created by Bema on 31/5/24.
//

import Foundation
import UIKit

class NotesVC: UIViewController, UIScrollViewDelegate {
    
    // MARK: - Properties
    var scrollView: UIScrollView!
    var pageControl: UIPageControl!
    
    let images = ["image 58", "image 58-2", "image 58-3", "image 58-4"]
    let texts = ["Badminton", "Valleyball", "Swimming", "Running"]
    let details = ["Badminton is a thorough aerobic exercise that has been shown to lower cholesterol and reduce the risk of fatal heart problems by almost a quarter if done regularly. It is a quick moving game perfect for either individuals or couples, but carries a relatively low risk of injury.",
    "Volleyball is most popular during the summer, but most big gyms will have the facilities to play it indoors all year round. Volleyball is a good choice as it can be easily understood and played by most people. It is also a fast, physically exerting game, but one that has a low risk of injury. The full equipment to play can easily be packed away and taken with you, so you don’t need a lot of planning to get a game going. These are just a few examples of sports that are easy for adults to pick up. Of course, if you have a sport in mind that you prefer, you should pursue that. But if you’re unsure of your level of fitness, or just looking for a way to increase the amount of physical activity in your life, these options are a good place to start.",
    "Swimming is the perfect example of a sport that can be exactly as social and as active as you want. With pools in gyms, schools, and hotels across the country, this is an activity most people can easily incorporate into their schedule. With beaches and lakes all over the island too, people have the option of using swimming as a way to keep fit, or to get outside. The gentle freedom of movement that waters allows also means that it is the perfect activity for people with physical injuries or limitations. There are also lots of different classes you could sign up for, such as aquarobics, or you have the option of simply doing lengths.",
    "Running is a popular sport because it can be social and solitary at the same time. By taking part in races and marathons, you can compete against and socialise with other people, but the only scoring that really matters is your own. Nobody expects you to come first in the Dublin marathon, but if you beat your best time, that’s impressive. It also gives you an opportunity to raise some money and awareness for causes you care about, or ones that affect friends and family."]
    
    // MARK: - UI
    
    let headerTitle = UILabel()
    private let addButton = UIButton()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setGradientBackground()
        setupUI()
        setupScroll()
    }
    
    // MARK: - ScrollView
    
    private func setupScroll() {
        scrollView = UIScrollView()
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: headerTitle.bottomAnchor, constant: 20),
            scrollView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3)
        ])
        
        // Настройка UIPageControl
        pageControl = UIPageControl()
        pageControl.numberOfPages = Int(ceil(Double(images.count) / 2.0))
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pageControl)
        
        NSLayoutConstraint.activate([
            pageControl.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 10),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        setupPages()
        
        pageControl.addTarget(self, action: #selector(pageControlChanged(_:)), for: .valueChanged)
    }
    
    func setupPages() {
        let pageWidth = view.frame.width
        let pageHeight = view.frame.height * 0.3
        let cellWidth = pageWidth / 2
        let cellHeight = pageHeight
        
        for (index, imageName) in images.enumerated() {
            let pageIndex = index / 2
            let xPos = CGFloat(pageIndex) * pageWidth + CGFloat(index % 2) * cellWidth
            
            let cellView = UIView(frame: CGRect(x: xPos, y: 0, width: cellWidth, height: cellHeight))
            
            let imageView = UIImageView(image: UIImage(named: imageName))
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            
            let label = UILabel()
            label.text = texts[index]
            label.textAlignment = .center
            label.textColor = .white
            label.translatesAutoresizingMaskIntoConstraints = false
            
            let stackView = UIStackView(arrangedSubviews: [imageView, label])
            stackView.axis = .vertical
            stackView.alignment = .fill
            stackView.distribution = .fill
            stackView.spacing = 5
            stackView.translatesAutoresizingMaskIntoConstraints = false
            
            cellView.addSubview(stackView)
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellTapped(_:)))
            cellView.addGestureRecognizer(tapGesture)
            cellView.isUserInteractionEnabled = true
            cellView.tag = index
            
            NSLayoutConstraint.activate([
                stackView.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 10),
                stackView.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -10),
                stackView.centerYAnchor.constraint(equalTo: cellView.centerYAnchor),
                imageView.heightAnchor.constraint(equalTo: cellView.heightAnchor, multiplier: 0.6)
            ])
            
            scrollView.addSubview(cellView)
        }
        
        let totalPages = Int(ceil(Double(images.count) / 2.0))
        scrollView.contentSize = CGSize(width: pageWidth * CGFloat(totalPages), height: pageHeight)
    }
    
    @objc func cellTapped(_ sender: UITapGestureRecognizer) {
        guard let cellView = sender.view else { return }
        let index = cellView.tag
        
        let detail = details[index]
        
        let detailVC = DetailViewController()
        detailVC.detailText = detail
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    @objc func pageControlChanged(_ sender: UIPageControl) {
        let currentPage = sender.currentPage
        let offset = CGPoint(x: CGFloat(currentPage) * view.frame.width, y: 0)
        scrollView.setContentOffset(offset, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / view.frame.width)
        pageControl.currentPage = Int(pageIndex)
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
        headerTitle.textColor = .white
        headerTitle.text = "Notes"
        headerTitle.textAlignment = .center
        headerTitle.font = .systemFont(ofSize: 30, weight: .bold)
        headerTitle.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(headerTitle)
        
        NSLayoutConstraint.activate([
            headerTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerTitle.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            headerTitle.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15)
        ])
    }
    
    @objc private func addButtonTapped() {
        let nextViewController = ScreenLoading()
        navigationController?.pushViewController(nextViewController, animated: true)
    }
}

class DetailViewController: UIViewController {
    
    var detailText: String?
    
    private let detailLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setGradientBackground()
        
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        detailLabel.textColor = .white
        detailLabel.backgroundColor = .clear
        view.addSubview(detailLabel)
        
       
        
        detailLabel.text = detailText
        detailLabel.textColor = .white
        
        NSLayoutConstraint.activate([
            detailLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            detailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            detailLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
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
}
