//
//  Mediator.swift
//  GoF_DesignPatterns
//
//  Created by Luis David Goyes Garces on 25/4/25.
//

protocol Mediator: AnyObject {
    func broadcast(message: String, from sender: String)
    func send(message: String, to recipient: String, from sender: String)
}

class ChatMediator: Mediator {
    private var users: [String: Colleague] = [:]
    
    func add(user: Colleague, name: String) {
        users[name] = user
    }
    
    func removeUser(with name: String) {
        users[name] = nil
    }
    
    func send(message: String, to recipient: String, from sender: String) {
        users[recipient]?.receive(message: message, from: sender)
    }
    
    func broadcast(message: String, from sender: String) {
        for (_, user) in users {
            if user.name != sender {
                user.receive(message: message, from: sender)
            }
        }
    }
}

protocol Colleague {
    var mediator: Mediator? { get set }
    var name: String { get set }
    func receive(message: String, from sender: String)
}

class ConcreteColleague: Colleague {
    weak var mediator: Mediator?
    var name: String = ""
    init(mediator: Mediator? = nil, name: String) {
        self.mediator = mediator
        self.name = name
    }
    
    func receive(message: String, from sender: String) {
        print("[\(name)]: Received message: \(message) from \(sender)")
    }
    
    func say(something: String) {
        mediator?.broadcast(message: something, from: name)
    }
    
    func send(privateMessage:String, to recipient: String) {
        mediator?.send(message: privateMessage, to: recipient, from: name)
    }
    
    func print(_ message: String) {
        Swift.print(message)
    }
}
