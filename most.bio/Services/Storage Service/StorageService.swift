//
//  StorageService.swift
//  most.bio
//
//  Created by Kirill Varshamov on 07.09.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

import Foundation
import CryptoKit

protocol StorageServiceProtocol: class {
    func getModelVersion() -> String
    func saveNewModel(_ source: URL, _ from: URL)
}

class StorageService: StorageServiceProtocol {
    let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

    func getModelVersion() -> String {
        
        var modelURL: URL?
        
        let fileManager = FileManager.default

        do {
            let fileURLs = try fileManager.contentsOfDirectory(at: documentsPath, includingPropertiesForKeys: nil)

            modelURL = fileURLs.filter {
                $0.pathExtension == "mlmodel"
            }.first
        } catch {
            print("Error while enumerating files \(documentsPath.path): \(error.localizedDescription)")
        }
        
        guard let url = modelURL else {
            fatalError("There is no model")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed open model")
        }
        
        let digest = SHA256.hash(data: data)
        
        let hash = String(describing: digest)
        
        print(hash)
        
        return hash
    }
    
    func saveNewModel(_ source: URL, _ from: URL) {
        
        let destinationURL = documentsPath.appendingPathComponent(source.lastPathComponent)
                
        let fileManager = FileManager.default
        try? fileManager.removeItem(at: destinationURL)
        
        do {
            try fileManager.copyItem(at: from, to: destinationURL)
        } catch {
            print("Could not copy file to disk: \(error.localizedDescription)")
        }
    }
}
