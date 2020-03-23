//
//  SessionTests.swift
//  AgentTests
//
//  Created by Tian Tong on 3/23/20.
//  Copyright © 2020 TTDP. All rights reserved.
//

import XCTest
@testable import Agent

class SessionTests: XCTestCase {
    
    var sut: Session!
    
    override func setUp() {
        sut = Session.shared
    }
    
    func testGetURLSession() {
        var session = sut.getURLSession(config: .standard, timeoutForRequest: 30, timeoutForResource: 60)
        XCTAssertEqual(session.configuration.timeoutIntervalForRequest, 30)
        XCTAssertEqual(session.configuration.timeoutIntervalForResource, 60)
        
        session = sut.getURLSession(config: .ephemeral, timeoutForRequest: 60, timeoutForResource: 60 * 60 * 24)
        XCTAssertEqual(session.configuration.timeoutIntervalForRequest, 60)
        XCTAssertEqual(session.configuration.timeoutIntervalForResource, 86400)
        
        session = sut.getURLSession(config: .background("bg"), timeoutForRequest: 60, timeoutForResource: 60 * 60 * 24 * 7)
        XCTAssertEqual(session.configuration.identifier, "bg")
        XCTAssertEqual(session.configuration.timeoutIntervalForRequest, 60)
        XCTAssertEqual(session.configuration.timeoutIntervalForResource, 604800)
    }
    
}
