//
//  RequestTests.swift
//  AgentTests
//
//  Created by Tian Tong on 3/23/20.
//  Copyright © 2020 TTDP. All rights reserved.
//

import XCTest
@testable import Agent

class RequestTests: XCTestCase {
    
    var sut: DataRequest!
    
    override func setUp() {
        do {
            sut = try DataRequest(urlString: "", method: .get, query: nil, params: nil, body: nil, headers: nil, urlSession: URLSession.shared)
            XCTAssertNotNil(sut)
        } catch {
            XCTFail()
        }
    }
    
    func testInit() {
        
    }
    
}
