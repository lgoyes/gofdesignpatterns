//
//  ProxyTests.swift
//  GoF_DesignPatterns
//
//  Created by Luis David Goyes Garces on 19/3/25.
//

import Testing
@testable import GoF_DesignPatterns

final class ProxyTests {
    
    @Test
    func basicTest() throws {
        let someFile = DefaultFile(content: "")
        
        let adminProxy: SomeFile = OwnerFileProxy(file: someFile)
        
        try adminProxy.write(content: "Hola")
        let result = try adminProxy.read()
        
        #expect(result == "Hola")
        
        let otherUserProxy: SomeFile = NonOwnerFileProxy(file: someFile)
        
        #expect(throws: SomeFileError.notAllowed) {
            try otherUserProxy.write(content: "Otro usuario no está permitido")
        }
    }
}
