//
//  LoginViewControllerSecond.swift
//  Vulcano
//
//  Created by Bema on 29/5/24.
//

import Foundation
import UIKit

import UIKit

class LoginViewControllerSecond: UIViewController {
    let dateFormatter = DateFormatter()
    //dateFormatter.dateFormat = "dd/MM/yyyy"
    var username: String?
    var completionHandler: ((String?) -> Void)?
    
    // MARK: - DatePicker
    
    let datePicker = UIDatePicker()
    
    // MARK: - UI
    
    private let headerView = AuthHeaderView(title: "Create your profile!", subTitle: "Enter your date of birth")
    
    let dateField = CustomTextField(fieldType: .dateOfBirth)
    private let nextButton = UIButton()
    private let dateOfBirth = UILabel()
    
    // MARK: - Lines
    
    private lazy var line: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor(hex: "#B00D22")
        line.layer.cornerRadius = 3
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    private lazy var secondLine: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor(hex: "#B00D22")
        line.layer.cornerRadius = 3
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    // MARK: - Lyfecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setGradientBackground()
        self.setupUI()
        setupDatePicker()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
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
        nextButton.setTitle("Next", for: .normal)
        nextButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        nextButton.layer.cornerRadius = 15
        nextButton.backgroundColor = UIColor(hex: "#B00D22")
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        
        dateOfBirth.textColor = UIColor(hex: "#B00D22")
        dateOfBirth.text = "Date of birth"
        dateOfBirth.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        
        self.view.addSubview(headerView)
        self.view.addSubview(dateField)
        self.view.addSubview(nextButton)
        dateField.addSubview(dateOfBirth)
        self.view.addSubview(line)
        self.view.addSubview(secondLine)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        dateField.translatesAutoresizingMaskIntoConstraints = false
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        dateOfBirth.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            line.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 145),
            line.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100),
            line.heightAnchor.constraint(equalToConstant: 4),
            line.widthAnchor.constraint(equalToConstant: 50),
            
            secondLine.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -145),
            secondLine.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100),
            secondLine.heightAnchor.constraint(equalToConstant: 4),
            secondLine.widthAnchor.constraint(equalToConstant: 50),
            
            dateOfBirth.centerXAnchor.constraint(equalTo: dateField.leadingAnchor, constant: 68),
            dateOfBirth.topAnchor.constraint(equalTo: dateField.topAnchor, constant: 2),
            dateOfBirth.widthAnchor.constraint(equalToConstant: 100),
            dateOfBirth.heightAnchor.constraint(equalToConstant: 20),
            
            self.headerView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
            self.headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.headerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.headerView.heightAnchor.constraint(equalToConstant: 270),
            
            self.dateField.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 30),
            self.dateField.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            self.dateField.heightAnchor.constraint(equalToConstant: 55),
            self.dateField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            self.nextButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.nextButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            self.nextButton.heightAnchor.constraint(equalToConstant: 50),
            self.nextButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85)
        ])
    }
    
    private func setupDatePicker() {
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: true)
        
        dateField.inputView = datePicker
        dateField.inputAccessoryView = toolbar
    }
    
    @objc func dateChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateField.text = dateFormatter.string(from: sender.date)
    }
    
    @objc func donePressed() {
        dateField.resignFirstResponder()
    }
    
    @objc private func nextButtonTapped() {
        let nextViewController = PersonalCard()
        nextViewController.username = username
        nextViewController.date = dateField.text
        navigationController?.pushViewController(nextViewController, animated: true)
        
        let newFriend = Friend(name: LoginViewController().usernameField.text ?? "None", date: dateField.text ?? "None")
        Friend.addFriend(newFriend)
        if let section = Friend.friends.firstIndex(where: { $0.contains(newFriend) }) {
            Friend.friends[section].insert(newFriend, at: 0)
        }

        if let dateString = dateField.text, !dateString.isEmpty, let dateOfBirth = dateFormatter.date(from: dateString) {
            let calendar = Calendar.current
            let ageComponents = calendar.dateComponents([.year], from: dateOfBirth, to: Date())
            if let age = ageComponents.year {
                nextViewController.age = "\(age)"
            } else {
                print("Error calculating age")
            }
        } else {
            print("Error date")
        }
    }
        
        
    func registerUser(username: String, dateOfBirth: String) {
            let url = URL(string: "https://netninjanation.fun/api/v2/new/register")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            
            let parameters: [String: Any] = [
                "username": username,
                "date_of_birth": dateOfBirth
            ]
            
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
            
            let task = session.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error: \(error)")
                    return
                }
                
                guard let data = data else {
                    print("No data")
                    return
                }
                
                do {
                    if let jsonResponse = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                        print("Response: \(jsonResponse)")
                        DispatchQueue.main.async {
                        }
                    }
                } catch {
                    print("JSON error: \(error)")
                }
            }
            
            task.resume()
        }
    }

    
extension LoginViewControllerSecond: URLSessionDelegate {
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        let trust = challenge.protectionSpace.serverTrust
        let credential = trust.map { URLCredential(trust: $0) }
        completionHandler(.useCredential, credential)
    }
}

