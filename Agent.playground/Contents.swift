import Agent

let agent = Agent(scheme: .https, host: "jsonplaceholder.typicode.com", session: .standard)

agent.get("") { response in
    print(response.statusCode)
    print(response.headerFields)
}
