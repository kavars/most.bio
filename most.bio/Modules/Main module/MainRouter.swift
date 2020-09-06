//
//  MainRouter.swift
//  most.bio
//
//  Created by Kirill Varshamov on 02.09.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

import Foundation

class MainRouter: MainRouterProtocol {
    // MARK: - Properties
    weak var viewController: MainViewController!
    
    
    // MARK: - Initializer
    init(viewController: MainViewController) {
        self.viewController = viewController
    }
    
    // MARK: - MainRouterProtocol methods
    
    func transmitToLoadSampleController() {
        print("Go to load sample module")
    }
}
