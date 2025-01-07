//
//  CompanyTests.swift
//  GoF_DesignPatterns
//
//  Created by Luis David Goyes Garces on 28/12/24.
//
import Testing
@testable import GoF_DesignPatterns

final class FakeCEO: CEO {
    override func greet() -> String {
        "some message"
    }
}

class CompanyTests {
    @Test func basicTest() {
        let ceo = FakeCEO(name: "", company: "")
        CEO.set(testingInstance: ceo)
        let sut = Company()
        let result = sut.greetingsFromCEO()
        #expect(result == "CEO says: some message")
    }
}


