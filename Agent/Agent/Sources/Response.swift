//
//  Response.swift
//  Agent
//
//  Created by Tian Tong on 3/16/20.
//  Copyright © 2020 TTDP. All rights reserved.
//

import Foundation

public struct Response {
    
    public let data: Data?
    public let urlResponse: URLResponse?
    public let error: Error?
    
    public var statusCode: Int {
        return (urlResponse as? HTTPURLResponse)?.statusCode ?? 0
    }
    
}
