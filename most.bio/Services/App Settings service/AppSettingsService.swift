//
//  AppSettingsService.swift
//  most.bio
//
//  Created by Kirill Varshamov on 06.09.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

import Foundation

protocol AppSettingsServiceProtocol: class {
    func savedIsFirstLaunch() -> Bool
    func saveIsFirstLaunch(with value: Bool)
}

class AppSettingsService: AppSettingsServiceProtocol {    
    private let kSavedIsFirstLaunch = "most.bio.savedIsFirstLaunch"
    
    func savedIsFirstLaunch() -> Bool {
        if UserDefaults.standard.object(forKey: kSavedIsFirstLaunch) != nil {
            let isFirstLaunch = UserDefaults.standard.bool(forKey: kSavedIsFirstLaunch)
            return isFirstLaunch
        }
        return true
    }
    
    func saveIsFirstLaunch(with value: Bool) {
        UserDefaults.standard.set(value, forKey: kSavedIsFirstLaunch)
        UserDefaults.standard.synchronize()
    }
}
