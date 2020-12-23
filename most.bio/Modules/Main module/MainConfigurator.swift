//
//  MainConfigurator.swift
//  most.bio
//
//  Created by Kirill Varshamov on 02.09.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

import Foundation

class MainConfigurator: MainConfiguratorProtocol {
    func configure(with view: MainViewController) {
        let presenter = MainPresenter(view: view)
        let interactor = MainInteractor(presenter: presenter)
        let router = MainRouter(viewController: view)
        
        view.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
