//
//  PrototypeTests.swift
//  GoF_DesignPatterns
//
//  Created by Luis David Goyes Garces on 29/4/25.
//

import Testing
@testable import GoF_DesignPatterns

class PrototypeTests {
    @Test
    func invalidCopyFromReferenceType() {
        let engine = CarEngine(type: "V8", displacement: 6000, power: 500, torque: 400, efficiency: 0.8, year: 2020)
        let referenceCar = Car(brand: "Toyota", color: "White", engine: engine, transmission: "Automatic", seats: 5, doors: 4, maxSpeed: 200, fuelType: "Gasoline", price: 20000, year: 2020)
        
        let newCar = referenceCar.clone()
        newCar.year = 2025
        newCar.engine.year = 2025
        
        #expect(referenceCar.year == 2020)
        #expect(referenceCar.engine.year == 2020)
    }
}
