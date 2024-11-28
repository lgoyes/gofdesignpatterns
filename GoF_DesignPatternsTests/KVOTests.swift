//
//  KVOTests.swift
//  GoF_DesignPatternsTests
//
//  Created by Luis David Goyes Garces on 28/11/24.
//

import Testing
@testable import GoF_DesignPatterns

struct KVOTests {

    @Test func someTest() {
        let subject = SomeSubject(name: "David")
        let observer = SomeObserver()
        
        subject.addObserver(
            observer,
            forKeyPath: #keyPath(SomeSubject.name),
            options: [.new, .old],
            context: nil)
        
        subject.name = "Luis"
        
        #expect(observer.result == "La propiedad con el keyPath 'name' antes era David y ahora tiene el valor Luis")
    }

}
