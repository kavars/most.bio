//
//  Network service.swift
//  most.bio
//
//  Created by Kirill Varshamov on 06.09.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

import Foundation
import Network

protocol NetworkServiceProtocol: class {
    var isConnected: Bool { get }
}

class NetworkService: NetworkServiceProtocol {
    var isConnected: Bool {
        get {
            var result: Bool = false
            
            let monitor = NWPathMonitor()
            
            monitor.pathUpdateHandler = { path in
                if path.status == .satisfied {
                    result = true
                } else {
                    result = false
                }
            }
            
            let queue = DispatchQueue(label: "most.bio.isConnectedMonitor")
            
            monitor.start(queue: queue)
            
            monitor.cancel()
            
            return result
        }
    }
}
