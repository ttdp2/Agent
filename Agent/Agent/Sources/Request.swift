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

class DataRequest {
    
    let urlSession: URLSession
    var urlRequest: URLRequest
    
    init(base: String, path: String, method: Method, querys: [String: Any]? = nil, params: [String: Any]? = nil, body: Data? = nil, headers: [String: String]? = nil, session: URLSession) throws {
        let encodedURL = try Encoding.encode(base: base, path: path, querys: querys)
        
        urlSession = session
        urlRequest = URLRequest(url: encodedURL)
        urlRequest.httpMethod = method.rawValue
        urlRequest.httpBody = body

        if let params = params {
            guard body == nil else {
                throw RequestError.paramsWithBody
            }
            
            let bodyData = try JSONSerialization.data(withJSONObject: params, options: [])
            urlRequest.httpBody = bodyData
        }
        
        if let headers = headers {
            for (key, value) in headers {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
    }
    
    func go(completion: @escaping (Response) -> Void) throws {
        let task = urlSession.dataTask(with: urlRequest) { data, urlResponse, error in
            completion(Response(data: data, urlResponse: urlResponse, error: error))
        }
        task.resume()
    }
    
}
