//
//  Socket.swift
//  Agent
//
//  Created by Tian Tong on 3/27/20.
//  Copyright © 2020 TTDP. All rights reserved.
//

import Foundation

public protocol WebSocketDelegate {
    func webSocket(ws: WebSocket, didReceive text: String)
    func webSocket(ws: WebSocket, didReceive data: Data)
}

public class WebSocket {
    
    let scheme: Scheme
    let host: String
    let session: URLSession
    
    var delegate: WebSocketDelegate?
    
    init(scheme: Scheme, host: String, session: URLSession) {
        self.scheme = scheme
        self.host = host
        self.session = session
    }
    
    func send(_ text: String) {
        
    }
    
    func send(_ data: Data) {
        
    }
    
}
