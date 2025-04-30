//
//  Visitor.swift
//  GoF_DesignPatterns
//
//  Created by Luis David Goyes Garces on 30/4/25.
//

// 1.5 + ( 2.1 + 3.2 )

class ExpressionEvaluatorVisitor: ExpressionVisitor {
    var result = 0.0
    func visit(expression: DoubleExpr) {
        result = expression.value
    }

    func visit(expression: AdditionExpr) {
        expression.left.accept(visitor: self)
        let leftResult = result
        expression.right.accept(visitor: self)
        let rightResult = result
        result = leftResult + rightResult
    }
}

class ExpressionPrinterVisitor: ExpressionVisitor {
    var result = ""
    func visit(expression: DoubleExpr) {
        result.append(String(expression.value))
    }

    func visit(expression: AdditionExpr) {
        result.append("(")
        expression.left.accept(visitor: self)
        result.append("+")
        expression.right.accept(visitor: self)
        result.append(")")
    }
}

protocol ExpressionVisitor {
    func visit(expression: DoubleExpr)
    func visit(expression: AdditionExpr)
}

protocol VisitableExpr {
    func accept(visitor: ExpressionVisitor)
}

class DoubleExpr: VisitableExpr {
    var value: Double
    init(value: Double) {
        self.value = value
    }
    func accept(visitor: any ExpressionVisitor) {
        visitor.visit(expression: self)
    }
}

class AdditionExpr: VisitableExpr {
    let left: VisitableExpr
    let right: VisitableExpr
    init(left: VisitableExpr, right: VisitableExpr) {
        self.left = left
        self.right = right
    }
    func accept(visitor: any ExpressionVisitor) {
        visitor.visit(expression: self)
    }
}
