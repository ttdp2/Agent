//
//  AgentTests.swift
//  AgentTests
//
//  Created by Tian Tong on 3/15/20.
//  Copyright © 2020 TTDP. All rights reserved.
//

import XCTest
@testable import Agent

class AgentTests: XCTestCase {
    
    var sut: Agent!

    override func setUp() {
        sut = Agent(host: "reqres.in")
    }
    
    func testInit() {
        XCTAssertEqual(sut.base, "https://reqres.in")
    }
    
    func testInitWithParams() {
        var agent = Agent(scheme: .http, host: "www.ttdp.com", session: .standard)
        XCTAssertEqual(agent.base, "http://www.ttdp.com")
        
        agent = Agent(scheme: .https, host: "www.ttdp.com", session: .ephemeral)
        XCTAssertEqual(agent.base, "https://www.ttdp.com")
        
        agent = Agent(scheme: .ws, host: "www.ttdp.com", session: .background("bg"))
        XCTAssertEqual(agent.base, "ws://www.ttdp.com")
        XCTAssertEqual(agent.session.configuration.identifier, "bg")
        
        agent = Agent(scheme: .wss, host: "www.ttdp.com")
        XCTAssertEqual(agent.base, "wss://www.ttdp.com")
    }

    func testGet() {
        sut.get("books") { _ in }
    }
    
    func testPut() {
        
    }
    
    func testPost() {
        
    }
    
    func testDelete() {
        
    }

}
