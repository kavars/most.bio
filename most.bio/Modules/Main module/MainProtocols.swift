//
//  MainProtocols.swift
//  most.bio
//
//  Created by Kirill Varshamov on 02.09.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

import Foundation

protocol MainViewProtocol: class {
    func setUpMainView()
    func addElementsOnView()
    func createConstraints()
    
    func continueWithoutInternetConnection()
    func newModelVersionAvailible()
    
    func noInternetConnectionAtFirstLaunch()
    func loadModelAtFirstLaunch(_ handler: @escaping (() -> Void))
}

protocol MainInteractorProtocol: class {
    func startApp()
}

protocol MainPresenterProtocol: class {
    var router: MainRouterProtocol! { set get }
    
    func configureView()
    
    func startButtonPressed()
    func noInternetConnectionAction()
    func loadNewModelVersionAction()
    
    // first launch alerts
    func noInternetConnectionAtFirstLaunchAction()
    func loadModelAtFirstLaunchAction(_ handler: @escaping (() -> Void))
    
    func updateProgress(progress: Float, totalSize: String)
}

protocol MainConfiguratorProtocol: class {
    func configure(with view: MainViewController)
}

protocol MainRouterProtocol: class {
    func transmitToLoadSampleController()
}
