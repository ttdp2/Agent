import Agent

let agent = Agent(host: "reqres.in")

agent.get("api/usrs/2") { response in
    let headers = response.headerFields
    let status = response.statusCode
    print(status, headers)
    
    if let data = response.data, let json = response.json {
        print(data, json)
    }
}

let params = ["name": "morpheus", "job": "leader"]
agent.put("api/users/2", params: params) { response in
    let status = response.statusCode
    
    if status == 200, let json = response.json {
        print(json)
    }
}

let data = try? JSONSerialization.data(withJSONObject: params)
agent.post("api/users", body: data) { response in
    let status = response.statusCode

    if status == 201, let json = response.json {
        print(json)
    }
}

agent.delete("api/users/2") { response in
    let status = response.statusCode
    print(status)
}

class WebSocketHandler: WebSocketDelegate {
    func webSocket(ws: WebSocket, didReceive text: String) {
        print(text)
        ws.send("World")
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
            ws.close()
        }
    }
    func webSocket(ws: WebSocket, didReceive data: Data) {
        print(data)
    }
    func webSocket(ws: WebSocket, error: Error) {
        print(error)
    }
}

let wsHandler = WebSocketHandler()
let webSocket = Agent(scheme: .wss, host: "echo.websocket.org").webSocket
webSocket.delegate = wsHandler
webSocket.send("Hello")
