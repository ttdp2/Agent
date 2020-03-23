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

struct DataRequest {
    
    let urlString: URL?
    let method: String
    let query: [String: Any]?
    let params: [String: Any]?
    let body: Data?
    let headers: [String: String]?
    let urlSession: URLSession
    
    init(urlString: String, method: Method, query: [String: Any]?, params: [String: Any]?, body: Data?, headers: [String: String]?, urlSession: URLSession) throws {
        self.urlString = URL(string: urlString)
        self.method = method.rawValue
        self.query = query
        self.params = params
        self.body = body
        self.headers = headers
        self.urlSession = urlSession
    }
    
    func go(completion: @escaping (Response) -> Void) throws {
        guard let url = urlString else {
            throw RequestError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method
        
        let task = urlSession.dataTask(with: urlRequest) { data, urlResponse, error in
            completion(Response(data: data, urlResponse: urlResponse, error: error))
        }
        task.resume()
    }
    
}
