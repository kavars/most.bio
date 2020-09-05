//
//  AppSettingsService.swift
//  most.bio
//
//  Created by Kirill Varshamov on 06.09.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

import Foundation

protocol AppSettingsServiceProtocol: class {
    func savedModelVersion() -> String
    func saveModelVersion(with value: String)
}

class AppSettingsService: AppSettingsServiceProtocol {    
    private let kSavedModelVersion = "most.bio.savedModelVersion"
    
    func savedModelVersion() -> String {
        if let modelVersion = UserDefaults.standard.string(forKey: kSavedModelVersion) {
            return modelVersion
        }
        return "No model"
    }
    
    func saveModelVersion(with value: String) {
        UserDefaults.standard.set(value, forKey: kSavedModelVersion)
        UserDefaults.standard.synchronize()
    }
}
