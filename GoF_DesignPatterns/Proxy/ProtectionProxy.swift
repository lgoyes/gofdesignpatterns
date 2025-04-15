//
//  ProtectionProxy.swift
//  GoF_DesignPatterns
//
//  Created by Luis David Goyes Garces on 19/3/25.
//

enum SomeFileError: Swift.Error {
    case notAllowed
}
protocol SomeFile {
    func read() throws(SomeFileError) -> String
    func write(content: String) throws(SomeFileError)
}

class DefaultFile: SomeFile {
    private var content: String
    init(content: String) {
        self.content = content
    }
    
    func read() throws(SomeFileError) -> String {
        content
    }
    
    func write(content: String) throws(SomeFileError) {
        self.content = content
    }
}

class OwnerFileProxy: SomeFile {
    private let subject: SomeFile
    init(file: SomeFile) {
        self.subject = file
    }
    
    func read() throws(SomeFileError) -> String {
        try subject.read()
    }
    func write(content: String) throws(SomeFileError) {
        try subject.write(content: content)
    }
}

class NonOwnerFileProxy: SomeFile {
    private let subject: SomeFile
    init(file: SomeFile) {
        self.subject = file
    }
    
    func read() throws(SomeFileError) -> String {
        try subject.read()
    }
    func write(content: String) throws(SomeFileError) {
        throw .notAllowed
    }
}
