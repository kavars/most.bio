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
    
    // MARK: - Elements
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
        
        button.addTarget(self, action: #selector(startButtonPressed), for: .touchUpInside)
        
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
    
    // MARK: - Action
    @objc func startButtonPressed() {
        presenter.startButtonPressed()
    }
    
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
    
    //MARK: - Alerts
    func continueWithoutInternetConnection() {
        let alertController = UIAlertController(title: "Нет интернет соединения", message: "Без интернет соединения не возможно проверить актуальность модели распознования.\nПродолжить без проверки модели?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "Продолжить", style: .default) { action in
            self.presenter.router.transmitToLoadSampleController()
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)

        if let actionViews = alertController.view.subviews.first?.subviews.first?.subviews {
            
            actionViews.first?.backgroundColor = .backgroundPurple
        }

        alertController.view.tintColor = .smallUltralightPurpleElements

        present(alertController, animated: true)
    }
    
    func newModelVersionAvailible() {
        let alertController = UIAlertController(title: "Доступна новая версия модели", message: "Доступна новая версия модели распознавания. Загрузить или продолжить со старой версией?", preferredStyle: .alert)
        
        let loadAction = UIAlertAction(title: "Загрузить", style: .default) { action in
            // load alert
        }
        
        let skipAction = UIAlertAction(title: "Продолжить", style: .default) { action in
            self.presenter.router.transmitToLoadSampleController()
        }
        
        alertController.addAction(skipAction)
        alertController.addAction(loadAction)

        if let actionViews = alertController.view.subviews.first?.subviews.first?.subviews {
            
            actionViews.first?.backgroundColor = .backgroundPurple
        }

        alertController.view.tintColor = .smallUltralightPurpleElements

        present(alertController, animated: true)
    }
    
    // First Launch
    func noInternetConnectionAtFirstLaunch() {
        let alertController = UIAlertController(title: "Нет интернет соединения", message: "При первом запуске приложения требуется загрузить модель распознавания.\nБез интернет соединения это не возможно сделать. Включите интернет соединение.", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "ОК", style: .default)
        
        alertController.addAction(okAction)

        if let actionViews = alertController.view.subviews.first?.subviews.first?.subviews {
            
            actionViews.first?.backgroundColor = .backgroundPurple
        }

        alertController.view.tintColor = .smallUltralightPurpleElements

        present(alertController, animated: true)
    }
    
    func loadModelAtFirstLaunch(_ handler: @escaping (() -> Void)) {
        let alertController = UIAlertController(title: "Загрузка модели", message: "При первом запуске приложения требуется загрузить модель распознавания.", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Загрузить", style: .default) { action in
            // load alert
            // recieve 'handler()' to load alert
            handler()
        }
        
        alertController.addAction(okAction)

        if let actionViews = alertController.view.subviews.first?.subviews.first?.subviews {
            
            actionViews.first?.backgroundColor = .backgroundPurple
        }

        alertController.view.tintColor = .smallUltralightPurpleElements

        present(alertController, animated: true)
    }
}

