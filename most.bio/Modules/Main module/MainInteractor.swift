//
//  MainInteractor.swift
//  most.bio
//
//  Created by Kirill Varshamov on 02.09.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

import Foundation

class MainInteractor: MainInteractorProtocol {
    // MARK: - Properties
    weak var presenter: MainPresenterProtocol!
    
    lazy var networkService: NetworkServiceProtocol = NetworkService()
    
    
    // MARK: - Initializer
    init(presenter: MainPresenterProtocol) {
        self.presenter = presenter
    }
    
    // MARK: - MainInteractorProtocol methods
    func startApp() {
        // 1. check internet connection
        if networkService.isConnected {
            // get model version to check new version
            // get new model or continue with old/actual
        } else {
            presenter.noInternetConnectionAction()
        }

    }
}
