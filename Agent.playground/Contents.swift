import Agent

let agent = Agent(scheme: .https, host: "www.ttdp.com", session: .standard)
let agent2 = Agent(host: "www.ttop.com")

print(agent.url)
print(agent2.url)
