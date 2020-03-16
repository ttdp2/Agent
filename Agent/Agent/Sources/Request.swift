//
//  Request.swift
//  Agent
//
//  Created by Tian Tong on 3/16/20.
//  Copyright © 2020 TTDP. All rights reserved.
//

import Foundation

enum Method: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case head = "HEAD"
    case patch = "PATCH"
    case delete = "DELETE"
}

public struct Request {
    
    let url: URL?
    let method: String
    let query: [String: Any]?
    let params: [String: Any]?
    let headers: [String: String]?
    let session: URLSession
    
    init(url: String, method: Method, query: [String: Any]?, params: [String: Any]?, headers: [String: String]?, session: Session) {
        self.url = URL(string: url)
        self.method = method.rawValue
        self.query = query
        self.params = params
        self.headers = headers
        self.session = URLSession.shared
    }
    
    func go(completion: @escaping (Response) -> Void) {
        guard let url = url else {
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method
        
        let task = session.dataTask(with: urlRequest) { data, urlResponse, error in
            completion(Response(data: data, urlResponse: urlResponse, error: error))
        }
        task.resume()
    }
    
}
