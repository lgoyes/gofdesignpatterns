//
//  ArithmeticInterpreterTests.swift
//  GoF_DesignPatterns
//
//  Created by Luis David Goyes Garces on 17/4/25.
//

import Testing
@testable import GoF_DesignPatterns

class ArithmeticInterpreterTests {
    
    @Test
    func lexing1() {
        let sut = Lexer(input: "(3+3)-2")
        sut.execute()
        let expectedResult = [LeftParenthesisToken(), IntegerToken(text: "3"), AdditionToken(), IntegerToken(text: "3"), RightParenthesisToken(), SubtractionToken(), IntegerToken(text: "2")]
        #expect(sut.getResult() == expectedResult)
    }
    
    @Test
    func lexing2() {
        let sut = Lexer(input: "3-22")
        sut.execute()
        let expectedResult = [IntegerToken(text: "3"), SubtractionToken(), IntegerToken(text: "22")]
        #expect(sut.getResult() == expectedResult)
    }
    
    @Test
    func parsing1() throws {
        let lexer = Lexer(input: "3-22")
        lexer.execute()
        let tokens = lexer.getResult()
        
        let sut = TokenParser(input: tokens)
        try sut.execute()
        let result = sut.getResult()
        
        #expect(result?.value == -19)
    }
    
    @Test
    func parsing2() throws {
        let lexer = Lexer(input: "(15+2)-3")
        lexer.execute()
        let tokens = lexer.getResult()
        
        let sut = TokenParser(input: tokens)
        try sut.execute()
        let result = sut.getResult()
        
        #expect(result?.value == 14)
    }
    
    @Test
    func parsing3() throws {
        let lexer = Lexer(input: "(15+2)-+3")
        lexer.execute()
        let tokens = lexer.getResult()
        
        let sut = TokenParser(input: tokens)
        
        #expect(throws: TokenParser.Error.invalidConsecutiveOperands) {
            try sut.execute()
        }
    }
}
