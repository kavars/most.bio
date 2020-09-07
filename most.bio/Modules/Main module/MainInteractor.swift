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
    lazy var appSettingsService: AppSettingsServiceProtocol = AppSettingsService()
    
    
    // MARK: - Initializer
    init(presenter: MainPresenterProtocol) {
        self.presenter = presenter
    }
    
    // MARK: - MainInteractorProtocol methods
    func startApp() {
        
        // First launch
        if appSettingsService.savedIsFirstLaunch() {
            if networkService.isConnected {
                // load model
                presenter.loadModelAtFirstLaunchAction {
                    self.appSettingsService.saveIsFirstLaunch(with: false)
                }
            } else {
                presenter.noInternetConnectionAtFirstLaunchAction()
            }
            
        } else {
            
            // Check model version
            if networkService.isConnected {
                
                // Check model version
                self.networkService.versionCheck { [weak self] isNewModelVersion, errorMessage in
                    if isNewModelVersion {
                        // new availible
                        self?.presenter.loadNewModelVersionAction()
                    } else {
                        // old is actual
                        self?.presenter.router.transmitToLoadSampleController()
                    }
                    
                    if !errorMessage.isEmpty {
                        print("VersionCheck error: " + errorMessage)
                    }
                }
                
            } else {
                // reconnect or countinue without check version
                presenter.noInternetConnectionAction()
            }
        }

    }
}
