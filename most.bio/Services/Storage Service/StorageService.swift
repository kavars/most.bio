//
//  StorageService.swift
//  most.bio
//
//  Created by Kirill Varshamov on 07.09.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

import Foundation

protocol StorageServiceProtocol: class {
    func getModelVersion() -> String
}

class StorageService: StorageServiceProtocol {
    func getModelVersion() -> String {
        return "Model"
    }
}
