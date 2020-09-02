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
    
    // MARK: - View Life Circle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(with: self)
        presenter.configureView()
    }

    // MARK: - MainViewProtocol methods
    func setUpMainView() {
        
    }
}

