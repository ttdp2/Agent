import Agent

let agent = Agent(scheme: .http, host: "jsonplaceholder.typicode.com", session: .standard)

agent.get("") { response in
    print(response.statusCode)
    print(response.headerFields)
}
