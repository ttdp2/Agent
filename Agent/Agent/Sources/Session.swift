//
//  Session.swift
//  Agent
//
//  Created by Tian Tong on 3/23/20.
//  Copyright © 2020 TTDP. All rights reserved.
//

import Foundation

class Session: NSObject {
    
    static let shared = Session()
    
    private override init() {}
    
    func getURLSession(config: Config, timeoutForRequest: TimeInterval, timeoutForResource: TimeInterval) -> URLSession {
        let configuration = getURLSessionConfiguration(config: config, timeoutForRequest: timeoutForRequest, timeoutForResource: timeoutForResource)
        
        switch config {
        case .standard:
            return URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
        case .ephemeral:
            return URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
        case .background:
            return URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
        }
    }
    
    private func getURLSessionConfiguration(config: Config, timeoutForRequest: TimeInterval, timeoutForResource: TimeInterval) -> URLSessionConfiguration {
        let sessionConfig: URLSessionConfiguration
        
        switch config {
        case .standard:
            sessionConfig = URLSessionConfiguration.default
        case .ephemeral:
            sessionConfig = URLSessionConfiguration.ephemeral
        case .background(let identifier):
            sessionConfig = URLSessionConfiguration.background(withIdentifier: identifier)
        }
        
        sessionConfig.timeoutIntervalForRequest = timeoutForRequest
        sessionConfig.timeoutIntervalForResource = timeoutForResource
        return sessionConfig
    }
    
}

extension Session: URLSessionDelegate {

}
