//
//  NetworkService.swift
//  most.bio
//
//  Created by Kirill Varshamov on 06.09.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

import Foundation
import Network

protocol NetworkServiceProtocol: class {
    var isConnected: Bool { get }
    
    func versionCheck(completion: @escaping (Bool, String) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    
    // MARK: - Properties
    lazy var storageService: StorageServiceProtocol = StorageService()
    
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    
    var errorMessage = ""
    var isNewModelVersion: Bool?
    
    // MARK: - NetworkServiceProtocol methods
    
    var isConnected: Bool {
        get {
            var result: Bool = false
            
            let monitor = NWPathMonitor()
            
            let group = DispatchGroup()
            group.enter()
            
            monitor.pathUpdateHandler = { path in
                if path.status == .satisfied {
                    result = true
                } else {
                    result = false
                }
                group.leave()
            }
            
            let queue = DispatchQueue(label: "most.bio.isConnectedMonitor")
            
            monitor.start(queue: queue)

            group.wait()

            monitor.cancel()
                        
            return result
        }
    }
    
    func versionCheck(completion: @escaping (Bool, String) -> Void) {
        dataTask?.cancel()
                
        if var urlComponents = URLComponents(string: "http://mysite.com") { // url
            urlComponents.query = "version=\(storageService.getModelVersion())"
            
            guard let url = urlComponents.url else {
                return
            }
            
            dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error in
                defer {
                    self?.dataTask = nil
                }
                
                if let error = error {
                    self?.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
                } else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                    
                    // 1. parse
                    self?.getIsNewModalVersion(data)
                    
                    guard let isNewModelVersion = self?.isNewModelVersion else {
                        return
                    }
                    
                    // 2. completion
                    DispatchQueue.main.async {
                        completion(isNewModelVersion, self?.errorMessage ?? "")
                    }
                    
                }
            }
            dataTask?.resume()
        }
    }
    
    // MARK: - Internal methods
    private func getIsNewModalVersion(_ data: Data) {
        var response: [String: Any]?
        
        do {
            response = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        } catch let parseError as NSError {
            errorMessage += "JSONSerialization error: \(parseError.localizedDescription)\n"
            return
        }
        
        guard let array = response!["result"] as? [Any] else {
            errorMessage += "Dictionary does not contain result key\n"
            return
        }
        
        if let isNewModelVersion = array.first as? Bool {
            self.isNewModelVersion = isNewModelVersion
        } else {
            errorMessage += "There is no 'isNewModalVersion'\n"
        }
    }
}
