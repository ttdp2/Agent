//
//  Error.swift
//  Agent
//
//  Created by Tian Tong on 3/23/20.
//  Copyright © 2020 TTDP. All rights reserved.
//

import Foundation

public enum RequestError: Error {
    case paramsWithBody
    case invalidURL(String)
    case encodingFailed(String)
}
