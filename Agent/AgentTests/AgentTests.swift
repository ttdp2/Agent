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
        let path = "api/users"
        let querys = ["page": 2]
        let headers = ["Authorization": "Bearer ABCDE..."]
        
        sut.get(path) { _ in }
        sut.get(path, querys: querys) { _ in }
        sut.get(path, headers: headers) { _ in }
        sut.get(path, querys: querys, headers: headers) { _ in }
        sut.get("api/users?page=2") { _ in }
    }
    
    func testPut() {
        let path = "api/users/2"
        let headers = ["Authorization": "Bearer ABCDE..."]
        let params = ["name": "morpheus", "job": "zion resident"]
        let data = try? JSONSerialization.data(withJSONObject: params)
        
        sut.put(path, params: params) { _ in }
        sut.put(path, params: params, headers: headers) { _ in }
        sut.put(path, body: data) { _ in }
        sut.put(path, body: data, headers: headers) { _ in }
    }
    
    func testPost() {
        let path = "api/users"
        let headers = ["Authorization": "Bearer ABCDE..."]
        let params = ["name": "morpheus", "job": "leader"]
        let data = try? JSONSerialization.data(withJSONObject: params)
        
        sut.post(path, params: params) { _ in }
        sut.post(path, params: params, headers: headers) { _ in }
        sut.post(path, body: data) { _ in }
        sut.post(path, body: data, headers: headers) { _ in }
    }
    
    func testDelete() {
        let path = "api/users/2"
        let headers = ["Authorization": "Bearer ABCDE..."]
        
        sut.delete(path) { _ in }
        sut.delete(path, headers: headers) { _ in }
    }
    
    func testWebSocket() {
        let socket = Agent(scheme: .ws, host: "echo.websocket.org").webSocket
        socket.send("Hello")
        
        let helloDate = "Hello".data(using: .utf8)!
        socket.send(helloDate)
    }

}
