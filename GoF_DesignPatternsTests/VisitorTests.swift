//
//  VisitorTests.swift
//  GoF_DesignPatterns
//
//  Created by Luis David Goyes Garces on 30/4/25.
//

import Testing

@testable import GoF_DesignPatterns

class VisitorTests {

    @Test
    func printingExpression() {
        // 1.5 + ( 2.1 + 3.2 )
        let expression = AdditionExpr(
            left: DoubleExpr(value: 1.5),
            right: AdditionExpr(
                left: DoubleExpr(value: 2.1),
                right: DoubleExpr(value: 3.2)
            )
        )
        let evaluator = ExpressionPrinterVisitor()
        expression.accept(visitor: evaluator)
        let result = evaluator.result
        
        #expect(result == "(1.5+(2.1+3.2))")
    }
    
    @Test
    func evaluatingExpression() {
        // 1.5 + ( 2.1 + 3.2 )
        let expression = AdditionExpr(
            left: DoubleExpr(value: 1.5),
            right: AdditionExpr(
                left: DoubleExpr(value: 2.1),
                right: DoubleExpr(value: 3.2)
            )
        )
        let evaluator = ExpressionEvaluatorVisitor()
        expression.accept(visitor: evaluator)
        let result = evaluator.result
        
        let accuracy = 0.000001
        let expectedResult = 6.8
        #expect(abs(result-expectedResult) <= accuracy)
    }
}
