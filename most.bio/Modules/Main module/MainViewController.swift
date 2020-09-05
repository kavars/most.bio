//
//  MainViewController.swift
//  most.bio
//
//  Created by Kirill Varshamov on 02.09.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, MainViewProtocol {
    // MARK: - Properties
    var presenter: MainPresenterProtocol!
    let configurator: MainConfiguratorProtocol = MainConfigurator()
    
    let logoView: UIImageView = {
        let image = UIImage(named: "icon")
        
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .white
        
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        
        label.text = "most.bio"
        label.font = .systemFont(ofSize: 17)
        label.textColor = .smallUltralightPurpleElements
        label.textAlignment = .center
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let startButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setTitle("Начать", for: .normal)
        button.tintColor = .backgroundPurple
        button.backgroundColor = .white
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
//        button.addTarget(self, action: #selector(), for: .touchUpInside)
        
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.titleLabel?.textAlignment = .center

        button.layer.shadowColor = UIColor(displayP3Red: 0.0, green: 0.0, blue: 0.0, alpha: 0.16).cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 0.0
        
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 14.0
        
        return button
    }()
    
    // MARK: - View Life Circle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(with: self)
        presenter.configureView()
    }

    // MARK: - MainViewProtocol methods
    func setUpMainView() {
        DispatchQueue.main.async {
            self.view = BackgroundView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
            self.view.backgroundColor = .backgroundPurple
        }
    }
    
    func addElementsOnView() {
        DispatchQueue.main.async {
            self.view.addSubview(self.logoView)
            self.view.addSubview(self.nameLabel)
            self.view.addSubview(self.startButton)
        }
    }
    
    func createConstraints() {
        DispatchQueue.main.async {
            NSLayoutConstraint.activate([
                self.logoView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                self.logoView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
                self.logoView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.273399),
                self.logoView.widthAnchor.constraint(equalTo: self.logoView.heightAnchor),
                
                self.nameLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                self.nameLabel.widthAnchor.constraint(equalToConstant: 70),
                self.nameLabel.heightAnchor.constraint(equalToConstant: 30),
                self.nameLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 50),
                
                self.startButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                self.startButton.heightAnchor.constraint(equalToConstant: 43),
                self.startButton.widthAnchor.constraint(equalToConstant: 277),
                self.startButton.topAnchor.constraint(equalTo: self.logoView.bottomAnchor, constant: 81),
            ])
        }
    }
}

