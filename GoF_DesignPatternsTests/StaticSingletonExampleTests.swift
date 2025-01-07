//
//  StaticSingletonExampleTests.swift
//  GoF_DesignPatterns
//
//  Created by Luis David Goyes Garces on 28/12/24.
//

import Testing
import XCTest
@testable import GoF_DesignPatterns

class StaticSingletonExampleXCTests: XCTestCase {
    override func setUp() {
        super.setUp()
        StaticSingletonExample.instance = StaticSingletonExample()
    }
    func testBasic() {
        let counter = StaticSingletonExample
            .sharedInstance() // someValue = 0
        counter.increment() // someValue = 1
        #expect(counter.getDescription() == "odd")
    }
    
    func testTwoConsecutiveIncrements() {
        let counter = StaticSingletonExample
            .sharedInstance() // someValue = 0
        counter.increment() // someValue = 1
        counter.increment() // someValue = 2
        #expect(counter.getValue() == 2)
    }
}

class StaticSingletonExampleTests {
    
    init() {
        StaticSingletonExample.instance = StaticSingletonExample()
    }
    
    @Test func basicTest() {
        let counter = StaticSingletonExample
            .sharedInstance() // someValue = 0
        counter.increment() // someValue = 1
        #expect(counter.getDescription() == "odd")
    }
    
    @Test func twoConsecutiveIncrements() {
        let counter = StaticSingletonExample
            .sharedInstance() // someValue = 0
        counter.increment() // someValue = 1
        counter.increment() // someValue = 2
        #expect(counter.getValue() == 2)
    }
}
