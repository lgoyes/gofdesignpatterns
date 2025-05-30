//
//  Lexer.swift
//  GoF_DesignPatterns
//
//  Created by Luis David Goyes Garces on 21/4/25.
//

class Token: Equatable {
    let text: String
    init(text: String) {
        self.text = text
    }
    static func == (lhs: Token, rhs: Token) -> Bool {
        lhs.text == rhs.text && type(of: lhs) == type(of: rhs)
    }
    func precedence() -> Int {
        0
    }
    func getOperator() -> BinaryOperationNode.Operator? {
        nil
    }
}

class IntegerToken: Token {
    
}

class AdditionToken: Token {
    init() {
        super.init(text: "+")
    }
    override func precedence() -> Int {
        1
    }
    override func getOperator() -> BinaryOperationNode.Operator? {
        .addition
    }
}

class SubtractionToken: Token {
    init() {
        super.init(text: "-")
    }
    override func precedence() -> Int {
        1
    }
    override func getOperator() -> BinaryOperationNode.Operator? {
        .subtraction
    }
}

class MultiplicationToken: Token {
    init() {
        super.init(text: "*")
    }
    override func precedence() -> Int {
        2
    }
    override func getOperator() -> BinaryOperationNode.Operator? {
        .multiplication
    }
}

class DivisionToken: Token {
    init() {
        super.init(text: "/")
    }
    override func precedence() -> Int {
        2
    }
    override func getOperator() -> BinaryOperationNode.Operator? {
        .division
    }
}

class LeftParenthesisToken: Token {
    init() {
        super.init(text: "(")
    }
    override func precedence() -> Int {
        -1
    }
}

class RightParenthesisToken: Token {
    init() {
        super.init(text: ")")
    }
    override func precedence() -> Int {
        -1
    }
}

class Lexer {
    private let input: String
    private var result: [Token] = []
    init(input: String) {
        self.input = input
    }
    func execute() {
        var i = 0
        while i < input.count {
            switch String(input[input.index(input.startIndex, offsetBy: i)]) {
            case "+":
                result.append(AdditionToken())
                i += 1
            case "-":
                result.append(SubtractionToken())
                i += 1
            case "*":
                result.append(MultiplicationToken())
                i += 1
            case "/":
                result.append(DivisionToken())
                i += 1
            case "(":
                result.append(LeftParenthesisToken())
                i += 1
            case ")":
                result.append(RightParenthesisToken())
                i += 1
            default:
                var integerString = ""
                for j in i..<input.count {
                    let char = String(input[input.index(input.startIndex, offsetBy: j)])
                    if Int(char) != nil {
                        integerString.append(char)
                    } else {
                        break
                    }
                }
                let integerToken = IntegerToken(text: integerString)
                result.append(integerToken)
                
                i += integerString.count
            }
        }
    }
    func getResult() -> [Token] {
        result
    }
}
