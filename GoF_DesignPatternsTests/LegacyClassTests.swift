//
//  LegacyClassTests.swift
//  GoF_DesignPatternsTests
//
//  Created by Luis David Goyes Garces on 10/12/24.
//

import Testing
@testable import GoF_DesignPatterns

class FakeSomeObject: SomeObject {
    var executeMethodToSenseCalled = false
    override func executeMethodToSense() {
        executeMethodToSenseCalled = true
    }
}

class TestingLegacyClass: LegacyClass {
    var someObject: FakeSomeObject!
    override func createSomeObject() -> SomeObject {
        someObject
    }
}

struct LegacyClassTests {

    @Test func extractFactoryMethod() {
        let fakeSomeObject = FakeSomeObject()
        
        let sut = TestingLegacyClass()
        sut.someObject = fakeSomeObject
        
        sut.someMethod()
        
        #expect(fakeSomeObject.executeMethodToSenseCalled)
    }

}
