//
//  AgentError.swift
//  Agent
//
//  Created by Tian Tong on 3/23/20.
//  Copyright © 2020 TTDP. All rights reserved.
//

import Foundation

public enum AgentError: Error {
    case requestError(RequestError)
    case responseError(Error)
}

public enum RequestError: Error {
    case encodingFailed
    case invalidURL
}
