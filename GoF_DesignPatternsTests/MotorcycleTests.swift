//
//  MotorcycleTests.swift
//  GoF_DesignPatternsTests
//
//  Created by Luis David Goyes Garces on 3/12/24.
//

import Testing
@testable import GoF_DesignPatterns

struct MotorcycleTests {

    @Test func basicTest() {
        let sut = YamahaSZR150(
            engine: Engine(),
            wheels: [])
        let result = sut.move()
        
        #expect(result ==
        "YamahaSZR150 moving")
    }
    
    @Test func motorcycleWithDecorators() {
        let sut = getDecoratedBike()
        let result = sut.move()
        
        #expect(result ==
        "YamahaSZR150 moving with trunk with sliders")
    }
    
    func getDecoratedBike() -> Motorcycle {
        var sut: Motorcycle = YamahaSZR150(
            engine: Engine(),
            wheels: [])
        
        sut = MotorcycleTrunk(wrapped: sut)
        sut = MotorcycleSliders(wrapped: sut)
        
        return sut
    }
}
