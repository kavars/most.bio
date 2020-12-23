//
//  DownloadService.swift
//  most.bio
//
//  Created by Kirill Varshamov on 08.09.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

import Foundation

protocol DownloadServiceProtocol: class {
    var downloadsSession: URLSession! { set get }
    
    var progress: Float { set get }
    var task: URLSessionDownloadTask? { set get }
}

class DownloadService: DownloadServiceProtocol {
    
    var downloadsSession: URLSession!
    
    var progress: Float = 0

    var task: URLSessionDownloadTask?
    
    let modelURL = URL(string: "path to the model")! //

    func cancelDownload() {
        task?.cancel()
        task = nil
    }
    
    func startDownload() {
        task = downloadsSession.downloadTask(with: modelURL)
        task?.resume()
    }
}
