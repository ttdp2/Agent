//
//  Agent.swift
//  Agent
//
//  Created by Tian Tong on 3/15/20.
//  Copyright © 2020 TTDP. All rights reserved.
//

import Foundation

public enum Scheme: String {
    case https
    case http
    case wss
    case ws
}

public enum SessionConfig: Equatable {
    case standard
    case ephemeral
    case background(String)
}

public struct Agent {
    
    public static var timeourForRequest: TimeInterval = 60 // 60 seconds
    public static var timeoutForResource: TimeInterval = 60 * 60 * 24 * 7 // 7 days
    
    let scheme: Scheme
    let host: String
    let session: URLSession
    
    public var url: String {
        return scheme.rawValue + "://" + host
    }
    
    public init(scheme: Scheme = .https, host: String, session: SessionConfig = .standard) {
        self.scheme = scheme
        self.host = host
        self.session = Session.shared.getURLSession(config: session, timeoutForRequest: Agent.timeourForRequest, timeoutForResource: Agent.timeoutForResource)
    }
    
    public func get(_ path: String, query: [String: Any]? = nil, headers: [String: String]? = nil, completion: @escaping (Response) -> Void) {
        do {
            let request = try DataRequest(urlString: url, method: .get, query: query, params: nil, body: nil, headers: headers, urlSession: session)
            
            try request.go(completion: completion)
        } catch(let error) {
            completion(Response(data: nil, urlResponse: nil, error: error))
        }
    }
    
    public func put(_ path: String, params: [String: Any]? = nil, headers: [String: String]? = nil, completion: @escaping (Response) -> Void) {
        
    }
    
    public func put(_ path: String, body: Data? = nil, headers: [String: String]? = nil, completion: @escaping (Response) -> Void) {
        
    }
    
    public func post(_ path: String, params: [String: Any]? = nil, headers: [String: String]? = nil, completion: @escaping (Response) -> Void) {
        
    }
    
    public func post(_ path: String, body: Data? = nil, headers: [String: String]? = nil, completion: @escaping (Response) -> Void) {
        
    }
    
    public func delete() {
        
    }
    
}
