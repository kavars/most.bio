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
    
    // MARK: - View Life Circle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(with: self)
        presenter.configureView()
    }

    // MARK: - MainViewProtocol methods
    func setUpMainView() {
        DispatchQueue.main.async {
            self.view.backgroundColor = .backgroundPurple
        }
    }
    
    func addElementsOnView() {
        DispatchQueue.main.async {
            self.view.addSubview(self.logoView)
        }
    }
    
    func createConstraints() {
        DispatchQueue.main.async {
            NSLayoutConstraint.activate([
                self.logoView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                self.logoView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
                self.logoView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.273399),
                self.logoView.widthAnchor.constraint(equalTo: self.logoView.heightAnchor)
            ])
        }
    }
}

