//
//  MediatorTests.swift
//  GoF_DesignPatterns
//
//  Created by Luis David Goyes Garces on 25/4/25.
//

import Testing
@testable import GoF_DesignPatterns

final class TestingConcreteColleague: ConcreteColleague {
    var log: (String) -> Void = { _ in }
    
    init(log: @escaping (String) -> Void, mediator: (any Mediator)?, name: String) {
        self.log = log
        super.init(mediator: mediator, name: name)
    }
    
    override func print(_ message: String) {
        log(message)
    }
}

final class MediatorTests {
    private var printedMessages: [String] = []
    @Test
    func example() {
        let mediator = ChatMediator()
        let user1 = TestingConcreteColleague(log: print, mediator: mediator, name: "User1")
        mediator.add(user: user1, name: "User1")
        
        let user2 = TestingConcreteColleague(log: print, mediator: mediator, name: "User2")
        mediator.add(user: user2, name: "User2")

        let user3 = TestingConcreteColleague(log: print, mediator: mediator, name: "User3")
        mediator.add(user: user3, name: "User3")
        
        user1.say(something: "Hola")
        user2.send(privateMessage: "Hola, User1", to: "User1")
        
        #expect(printedMessages.sorted() == [
            "[User1]: Received message: Hola from Mediator",
            "[User1]: Received message: Hola, User1 from User2",
            "[User2]: Received message: Hola from Mediator",
            "[User3]: Received message: Hola from Mediator"
        ])
    }
    func print(_ message: String) {
        printedMessages.append(message)
    }
}
