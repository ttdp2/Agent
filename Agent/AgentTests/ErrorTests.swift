//
//  ErrorTests.swift
//  AgentTests
//
//  Created by Tian Tong on 3/27/20.
//  Copyright © 2020 TTDP. All rights reserved.
//

import XCTest
@testable import Agent

class ErrorTests: XCTestCase, WebSocketDelegate {
    
    func webSocket(ws: WebSocket, didReceive text: String) {
        
    }
    
    func webSocket(ws: WebSocket, didReceive data: Data) {
        
    }
    
    func webSocket(ws: WebSocket, error: Error) {
        print(error)
    }

    func testSocketSchemeError() {
        let agent = Agent(scheme: .http, host: "echo.websocket.org")
        let sut = agent.webSocket
        
        sut.delegate = self
        sut.send("Hello")
    }
    
    func testSocketSessionError() {
        let agent = Agent(scheme: .ws, host: "echo.websocket.org", session: .background("bg"))
        let sut = agent.webSocket
        
        sut.delegate = self
        sut.send("Hello")
    }
    
}
