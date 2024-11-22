//
//  TextProcessorTests.swift
//  GoF_DesignPatternsTests
//
//  Created by Luis David Goyes Garces on 22/11/24.
//

import Testing
@testable import GoF_DesignPatterns

struct TextProcessorTests {

    @Test func markdownParsing() {
        let sut = TextProcessor(formatStrategy: MarkdownFormatStrategy())
        sut.append(items: ["uno", "dos", "tres"])
        let expectedResult = """
         * uno
         * dos
         * tres
        
        """
        #expect(sut.description == expectedResult)
    }
    
    @Test func htmlParsing() {
        let sut = TextProcessor(formatStrategy: HtmlFormatStrategy())
        sut.append(items: ["uno", "dos", "tres"])
        let expectedResult = """
        <ul>
         <li>uno</li>
         <li>dos</li>
         <li>tres</li>
        </ul>
        
        """
        #expect(sut.description == expectedResult)
    }
    
    @Test func switchingStrategies() {
        let sut = TextProcessor(
            formatStrategy: HtmlFormatStrategy())
        sut.append(items: ["uno", "dos", "tres"])
        sut.clear()
        
        sut.setFormatStrategy(
            MarkdownFormatStrategy())
        sut.append(items: ["uno", "dos", "tres"])
        let expectedResult = """
         * uno
         * dos
         * tres
        
        """
        #expect(sut.description == expectedResult)
    }
}
