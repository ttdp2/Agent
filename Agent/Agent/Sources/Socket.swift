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
    func webSocket(ws: WebSocket, error: Error)
}

public class WebSocket {

    private let socketTask: URLSessionWebSocketTask?
    private var error: RequestError?
    
    public var delegate: WebSocketDelegate?
    
    init(scheme: Scheme, host: String, config: Config) {
        guard scheme == .ws || scheme == .wss else {
            socketTask = nil
            error = .socketSchemeError
            return
        }
        
        guard config == .standard || config == .ephemeral else {
            socketTask = nil
            error = .socketSessionError
            return
        }
        
        guard let url = URL(string: scheme.rawValue + "://" + host) else {
            error = .invalidURL(host)
            socketTask = nil
            return
        }

        let session = Session.shared.getURLSession(config: config, timeoutForRequest: Agent.timeourForRequest, timeoutForResource: Agent.timeourForRequest)
        
        socketTask = session.webSocketTask(with: url)
        socketTask?.resume()
        listen()
    }
    
    public func send(_ text: String) {
        if let error = error {
            delegate?.webSocket(ws: self, error: error)
            return
        }
        
        let message = URLSessionWebSocketTask.Message.string(text)
        socketTask?.send(message) { [weak self] error in
            if let error = error {
                guard let self = self else { return }
                self.delegate?.webSocket(ws: self, error: error)
            }
        }
    }
    
    public func send(_ data: Data) {
        if let error = error {
            delegate?.webSocket(ws: self, error: error)
            return
        }
        
        let message = URLSessionWebSocketTask.Message.data(data)
        socketTask?.send(message) { [weak self] error in
            if let error = error {
                guard let self = self else { return }
                self.delegate?.webSocket(ws: self, error: error)
            }
        }
    }
    
    public func close() {
        socketTask?.cancel()
    }
    
    private func listen() {
        socketTask?.receive { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .failure(let error):
                self.delegate?.webSocket(ws: self, error: error)
            case .success(let message):
                switch message {
                case .string(let text):
                    self.delegate?.webSocket(ws: self, didReceive: text)
                case .data(let data):
                    self.delegate?.webSocket(ws: self, didReceive: data)
                @unknown default:
                    print("Unknow mesasge type")
                }
                self.listen()
            }
        }
    }
    
}
