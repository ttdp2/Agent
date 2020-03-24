//
//  Encoding.swift
//  Agent
//
//  Created by Tian Tong on 3/24/20.
//  Copyright © 2020 TTDP. All rights reserved.
//

import Foundation

struct Encoding {
    
    static func encode(base: String, path: String, querys: [String: Any]? = nil) throws -> URL {
        
        var urlString: String
        if path.starts(with: "/") {
            urlString = base + path
        } else {
            urlString = base + "/" + path
        }
        
        guard let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            throw RequestError.encodingFailed(urlString)
        }
        
        guard let encodedURL = URL(string: encodedString) else {
            throw RequestError.invalidURL(urlString)
        }
        
        if let querys = querys {
            guard let urlComponents = URLComponents(string: encodedString) else {
                throw RequestError.invalidURL(urlString)
            }
            
            let queryString = Encoding.composeQueryString(urlComponents, with: querys)
            
            guard let encodedQueryString = queryString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
                throw RequestError.encodingFailed(queryString)
            }
            
            let urlQueryString = encodedURL.absoluteString + encodedQueryString
            guard let encodedURLQueryString = URL(string: urlQueryString) else {
                throw RequestError.invalidURL(urlQueryString)
            }
            return encodedURLQueryString
        }
        
        return encodedURL
    }
    
    private static func composeQueryString(_ urlComponents: URLComponents, with querys: [String: Any]) -> String {
        var queryString = "?"
        
        if let query = urlComponents.query {
            queryString = query.isEmpty ? "" : "&"
        }
        
        var isFirst = true
        for (key, value) in querys {
            if isFirst {
                queryString += "\(key)=\(value)"
                isFirst = false
            } else {
                queryString += "&\(key)=\(value)"
            }
        }
        
        return queryString
    }
    
}
