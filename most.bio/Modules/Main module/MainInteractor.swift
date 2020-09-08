//
//  MainInteractor.swift
//  most.bio
//
//  Created by Kirill Varshamov on 02.09.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

import Foundation

class MainInteractor: NSObject, MainInteractorProtocol {
    // MARK: - Properties
    weak var presenter: MainPresenterProtocol!
    
    lazy var networkService: NetworkServiceProtocol = NetworkService()
    lazy var downloadService: DownloadServiceProtocol = DownloadService()
    lazy var appSettingsService: AppSettingsServiceProtocol = AppSettingsService()
    lazy var storageService: StorageServiceProtocol = StorageService()
    
    lazy var downloadsSession: URLSession = {
        let configuration = URLSessionConfiguration.default
        
        return URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
    }()
    
    // MARK: - Initializer
    init(presenter: MainPresenterProtocol) {
        super.init()
        
        self.presenter = presenter
        
        downloadService.downloadsSession = downloadsSession
    }
    
    // MARK: - MainInteractorProtocol methods
    func startApp() {
        
        // First launch
        if appSettingsService.savedIsFirstLaunch() {
            if networkService.isConnected {
                // load model
                presenter.loadModelAtFirstLaunchAction { // TODO
                    self.appSettingsService.saveIsFirstLaunch(with: false)
                }
            } else {
                presenter.noInternetConnectionAtFirstLaunchAction()
            }
            
        } else {
            
            // Check model version
            if networkService.isConnected {
                
                // Check model version
                self.networkService.versionCheck { [weak self] isNewModelVersion, errorMessage in
                    if isNewModelVersion {
                        // new availible
                        self?.presenter.loadNewModelVersionAction() // TODO
                    } else {
                        // old is actual
                        self?.presenter.router.transmitToLoadSampleController()
                    }
                    
                    if !errorMessage.isEmpty {
                        print("VersionCheck error: " + errorMessage)
                    }
                }
                
            } else {
                // reconnect or countinue without check version
                presenter.noInternetConnectionAction()
            }
        }

    }
}

extension MainInteractor: URLSessionDownloadDelegate {
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        
        guard let sourceURL = downloadTask.originalRequest?.url else {
            return
        }
                
        storageService.saveNewModel(sourceURL, location)
        
        downloadService.task = nil
        
        // Transition to Sample screen
        DispatchQueue.main.async {
            self.presenter.router.transmitToLoadSampleController()
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        
        downloadService.progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
        
        let totalSize = ByteCountFormatter.string(fromByteCount: totalBytesExpectedToWrite, countStyle: .file)
        
        // Update progress view
        DispatchQueue.main.async {
            self.presenter.updateProgress(progress: self.downloadService.progress, totalSize: totalSize)
        }
    }
}
