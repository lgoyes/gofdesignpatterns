//
//  PropertyObserver.swift
//  GoF_DesignPatterns
//
//  Created by Luis David Goyes Garces on 28/11/24.
//

struct Dog {
    var name: String
    var breed: String
}

class SomeClass {
    var name : String {
        didSet {
            print("Name changed from \(oldValue) to \(name)")
        }
        willSet {
            print("Name will change from \(name) to \(newValue)")
        }
    }
    
    init(name: String) {
        self.name = name
    }
}
