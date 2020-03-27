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

    func testNeedSocketScheme() {
        let socket = Agent(scheme: .wss, host: "echo.websocket.org").socket
        socket.delegate = self
        
        socket.send("Hello")
    }
    
}
