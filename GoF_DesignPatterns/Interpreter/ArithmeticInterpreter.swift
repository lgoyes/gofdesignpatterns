//
//  ArithmeticInterpreter.swift
//  GoF_DesignPatterns
//
//  Created by Luis David Goyes Garces on 17/4/25.
//

protocol Element {
    var value: Int { get }
}

struct Integer: Element {
    let value: Int
    init(_ value: Int) {
        self.value = value
    }
}

class BinaryOperation: Element {
    enum Error: Swift.Error {
        case invalidNumberOfOperands
    }
    
    var left: Element = Integer(0)
    var right: Element = Integer(0)
    private var lhsSet = false
    private var rhsSet = false
    
    var value: Int {
        0
    }
    func setValue(element: Element) throws(BinaryOperation.Error) {
        if !lhsSet {
            left = element
            lhsSet = true
        } else if !rhsSet {
            right = element
            rhsSet = true
        } else {
            throw .invalidNumberOfOperands
        }
    }
}

class Addition: BinaryOperation {
    override var value: Int {
        left.value + right.value
    }
}

class Subtraction: BinaryOperation {
    override var value: Int {
        left.value - right.value
    }
}

class Token: Equatable {
    let text: String
    init(text: String) {
        self.text = text
    }
    static func == (lhs: Token, rhs: Token) -> Bool {
        lhs.text == rhs.text && type(of: lhs) == type(of: lhs)
    }
}

class IntegerToken: Token {
    
}

class AdditionToken: Token {
    init() {
        super.init(text: "+")
    }
}

class SubtractionToken: Token {
    init() {
        super.init(text: "-")
    }
}

class LeftParenthesisToken: Token {
    init() {
        super.init(text: "(")
    }
}

class RightParenthesisToken: Token {
    init() {
        super.init(text: ")")
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
            case "-":
                result.append(SubtractionToken())
            case "(":
                result.append(LeftParenthesisToken())
            case ")":
                result.append(RightParenthesisToken())
            default:
                var integerString = ""
                for j in i..<input.count {
                    let char = String(input[input.index(input.startIndex, offsetBy: j)])
                    if Int(char) != nil {
                        integerString.append(char)
                        i += 1
                    } else {
                        i -= 1
                        break
                    }
                }
                let integerToken = IntegerToken(text: integerString)
                result.append(integerToken)
            }
            i += 1
        }
    }
    func getResult() -> [Token] {
        result
    }
}

class TokenParser {
    enum Error: Swift.Error {
        case invalidConsecutiveOperands
    }
    private let input: [Token]
    private var result: Element?
    
    init(input: [Token]) {
        self.input = input
    }
    
    func execute() throws {
        var i = 0
        while i < input.count {
            let token = input[i]
            switch token {
            case is AdditionToken, is SubtractionToken:
                if result is BinaryOperation {
                    throw Error.invalidConsecutiveOperands
                } else if let lhs = result as? Integer {
                    let operation: BinaryOperation
                    if token is AdditionToken {
                        operation = Addition()
                    } else {
                        operation = Subtraction()
                    }
                    try operation.setValue(element: lhs)
                    self.result = operation
                }
            case is IntegerToken:
                let integerElement = Integer(Int(token.text)!)
                if let result = result as? BinaryOperation {
                    try result.setValue(element: integerElement)
                } else {
                    result = integerElement
                }
            case is LeftParenthesisToken:
                var rightParenthesisIndex = i
                while rightParenthesisIndex < input.count {
                    if input[rightParenthesisIndex] is RightParenthesisToken {
                        break
                    }
                    rightParenthesisIndex += 1
                }
                let subexpression = Array(input[(i+1) ..< rightParenthesisIndex])
                let elementParser = TokenParser(input: subexpression)
                try elementParser.execute()
                if let parenthesisResult = elementParser.getResult() {
                    if let result = result as? BinaryOperation {
                        try result.setValue(element: parenthesisResult)
                    } else {
                        result = parenthesisResult
                    }
                }
                i = rightParenthesisIndex
                
            default:
                break
            }
            i += 1
        }
    }
    
    func getResult() -> Element? {
        if let result {
            return Integer(result.value)
        }
        return nil
    }
}
