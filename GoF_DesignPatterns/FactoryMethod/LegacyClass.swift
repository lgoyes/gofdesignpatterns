//
//  LegacyClass.swift
//  GoF_DesignPatterns
//
//  Created by Luis David Goyes Garces on 10/12/24.
//

class LegacyClass {
    
    // ...
    
    func someMethod() {
        // ...
        
        let someObject = createSomeObject()
        someObject.executeMethodToSense()
        
        // ...
    }
    
    func createSomeObject() -> SomeObject {
        SomeObject()
    }
}

class SomeObject {
    func executeMethodToSense() {
        
    }
}
