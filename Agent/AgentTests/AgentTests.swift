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
        sut = Agent(host: "www.ttdp.com")
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGet() {
        sut.get("books") { _ in }
    }

}
