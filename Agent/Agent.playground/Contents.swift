import Agent

let agent = Agent(scheme: .https, host: "www.ttdp.com", session: .standard)
let agent2 = Agent(host: "www.ttdp.com")

print(agent)
print(agent2)
print(agent.url)
