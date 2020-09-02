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
    
    
    // MARK: - Initializer
    init(presenter: MainPresenterProtocol) {
        self.presenter = presenter
    }
}
