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

public enum SessionConfig {
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
    
    public var base: String {
        return scheme.rawValue + "://" + host
    }
    
    public init(scheme: Scheme = .https, host: String, session: SessionConfig = .standard) {
        self.scheme = scheme
        self.host = host
        self.session = Session.shared.getURLSession(config: session, timeoutForRequest: Agent.timeourForRequest, timeoutForResource: Agent.timeoutForResource)
    }
    
    public func get(_ path: String, querys: [String: Any]? = nil, headers: [String: String]? = nil, completion: @escaping (Response) -> Void) {
        do {
            try DataRequest(base: base,
                            path: path,
                            method: .get,
                            querys: querys,
                            headers: headers,
                            session: session)
                .go(completion: completion)
        } catch {
            completion(Response(error: error))
        }
    }
    
    public func put(_ path: String, params: [String: Any]?, headers: [String: String]? = nil, completion: @escaping (Response) -> Void) {
        do {
            try DataRequest(base: base,
                            path: path,
                            method: .put,
                            params: params,
                            headers: headers,
                            session: session)
                .go(completion: completion)
        } catch {
            completion(Response(error: error))
        }
    }
    
    public func put(_ path: String, body: Data?, headers: [String: String]? = nil, completion: @escaping (Response) -> Void) {
        do {
            try DataRequest(base: base,
                            path: path,
                            method: .put,
                            body: body,
                            headers: headers,
                            session: session)
                .go(completion: completion)
        } catch {
            completion(Response(error: error))
        }
    }
    
    func put<T: Encodable>(_ path: String, encoder: T, headers: [String: String]? = nil, completion: @escaping (Response) -> Void) {
        
    }
    
    public func post(_ path: String, params: [String: Any]?, headers: [String: String]? = nil, completion: @escaping (Response) -> Void) {
        do {
            try DataRequest(base: base,
                            path: path,
                            method: .post,
                            params: params,
                            headers: headers,
                            session: session)
                .go(completion: completion)
        } catch {
            completion(Response(error: error))
        }
    }
    
    public func post(_ path: String, body: Data?, headers: [String: String]? = nil, completion: @escaping (Response) -> Void) {
        do {
            try DataRequest(base: base,
                            path: path,
                            method: .post,
                            body: body,
                            headers: headers,
                            session: session)
                .go(completion: completion)
        } catch {
            completion(Response(error: error))
        }
    }
    
    public func delete(_ path: String, headers: [String: String]? = nil, completion: @escaping (Response) -> Void) {
        do {
            try DataRequest(base: base,
                            path: path,
                            method: .delete,
                            session: session)
                .go(completion: completion)
        } catch {
            completion(Response(error: error))
        }
    }
    
}
