//
//  ArithmeticInterpreter.swift
//  GoF_DesignPatterns
//
//  Created by Luis David Goyes Garces on 17/4/25.
//

protocol Expression {
    func interpret() -> Int
}

struct NumberExpression: Expression {
    private let value: Int
    init(_ value: Int) {
        self.value = value
    }
    func interpret() -> Int {
        value
    }
}

class BinaryOperationNode: Expression {
    enum Operator {
        case addition, subtraction, multiplication, division
    }
    
    enum Error: Swift.Error {
        case invalidNumberOfOperands
    }
    
    var left: Expression = NumberExpression(0)
    var right: Expression = NumberExpression(0)
    var `operator`: Operator = .addition
    init(left: Expression, right: Expression, operator: Operator) {
        self.left = left
        self.right = right
        self.`operator` = `operator`
    }
    
    func interpret() -> Int {
        switch `operator` {
        case .addition:
            return left.interpret() + right.interpret()
        case .subtraction:
            return left.interpret() - right.interpret()
        case .multiplication:
            return left.interpret() * right.interpret()
        case .division:
            return left.interpret() / right.interpret()
        }
    }
}

class TokenInterator {
    private let tokens: [Token]
    private var position = 0
    
    init(tokens: [Token]) {
        self.tokens = tokens
    }
    
    func peek() -> Token? {
        if position < tokens.count {
            return tokens[position]
        }
        return nil
    }
    
    func getNext() -> Token? {
        guard let token = peek() else {
            return nil
        }
        position += 1
        return token
    }
}

class DescendentTokenParser {
    enum Error: Swift.Error, Equatable {
        case expectedTokenNotFound(Token.Type)
        case unexpectedToken(String)
        case unexpectedEndOfInput
        public static func == (lhs: Error, rhs: Error) -> Bool {
            switch (lhs, rhs) {
            case (.expectedTokenNotFound(let lhsType), .expectedTokenNotFound(let rhsType)):
                return lhsType == rhsType
            case (.unexpectedToken(let lhsString), .unexpectedToken(let rhsString)):
                return lhsString == rhsString
            case (.unexpectedEndOfInput, .unexpectedEndOfInput):
                return true
            default:
                return false
            }
        }
    }
    
    private let interator: TokenInterator
    init(tokens: [Token]) {
        self.interator = TokenInterator(tokens: tokens)
    }
    
    func parse() throws -> Expression {
        return try parseExpression()
    }
    
    private func parseExpression(precedence: Int = 0) throws(Error) -> Expression {
        var left = try parsePrimary()
        
        while let currentToken = interator.peek(),
              currentToken.precedence() >= precedence {
            
            _ = interator.getNext()
            
            let right = try parseExpression(precedence: currentToken.precedence() + 1)
            guard let `operator` = currentToken.getOperator() else {
                throw Error.unexpectedToken(currentToken.text)
            }
            left = BinaryOperationNode(left: left, right: right, operator: `operator`)
        }
        
        return left
    }
    
    private func parsePrimary() throws(Error) -> Expression {
        guard let token = interator.getNext() else {
            throw .unexpectedEndOfInput
        }
        
        if let numericToken = token as? IntegerToken {
            return NumberExpression(Int(numericToken.text)!)
        } else if token is LeftParenthesisToken {
            let expression = try parseExpression()
            try expect(RightParenthesisToken.self)
            return expression
        }
        
        throw .unexpectedToken(token.text)
    }
    
    @discardableResult
    private func expect(_ tokenType: Token.Type) throws(Error) -> Token {
        guard let token = interator.getNext(), type(of: token) == tokenType else {
            throw .expectedTokenNotFound(tokenType)
        }
        return token
    }
}

