//
//  MainPresenter.swift
//  most.bio
//
//  Created by Kirill Varshamov on 02.09.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

import Foundation

class MainPresenter: MainPresenterProtocol {
    // MARK: - Properties
    weak var view: MainViewProtocol!
    var interactor: MainInteractorProtocol!
    var router: MainRouterProtocol!
    
    // MARK: - Initializer
    init(view: MainViewProtocol) {
        self.view = view
    }
    
    // MARK: - Configure View
    func configureView() {
        view.setUpMainView()
        view.addElementsOnView()
        view.createConstraints()
    }
    
    // MARK: - MainPresenterProtocol methods
    func startButtonPressed() {
        interactor.startApp()
    }
    
    func noInternetConnectionAction() {
        view.continueWithoutInternetConnection()
    }
}
