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
    
    func testRequestWithQuery() {
        sut = try? DataRequest(base: "http://reqres.in", path: "api/users/2", method: .get, session: URLSession.shared)
        XCTAssertNotNil(sut)
        
        var urlString = sut.urlRequest.url?.absoluteString
        XCTAssertEqual(urlString, "http://reqres.in/api/users/2")
        
        sut = try? DataRequest(base: "http://reqres.in", path: "api/users", method: .get, querys: ["page": 2, "delay": 3], session: URLSession.shared)
        XCTAssertNotNil(sut)
        
        urlString = sut.urlRequest.url?.absoluteString
        let case1 = urlString == "http://reqres.in/api/users?page=2&delay=3"
        let case2 = urlString == "http://reqres.in/api/users?delay=3&page=2"
        XCTAssert(case1 || case2)
    }
    
    func testRequestWithParams() {
        
    }
    
    func testRequestWithBody() {
        
    }
    
}
