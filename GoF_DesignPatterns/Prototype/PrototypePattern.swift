//
//  PrototypePattern.swift
//  GoF_DesignPatterns
//
//  Created by Luis David Goyes Garces on 29/4/25.
//

class CarEngine: Prototype {
    private let type: String
    private let displacement: Int
    private let power: Int
    private let torque: Int
    private let efficiency: Double
    var year: Int
    init(type: String, displacement: Int, power: Int, torque: Int, efficiency: Double, year: Int) {
        self.type = type
        self.displacement = displacement
        self.power = power
        self.torque = torque
        self.efficiency = efficiency
        self.year = year
    }
    required init(copyFrom prototype: CarEngine) {
        self.type = prototype.type
        self.displacement = prototype.displacement
        self.power = prototype.power
        self.torque = prototype.torque
        self.efficiency = prototype.efficiency
        self.year = prototype.year
    }
    func clone() -> Self {
        return Self.init(copyFrom: self)
    }
    // other methods
}

protocol Prototype {
    func clone() -> Self
}

class Car: Prototype {
    private let brand: String
    private let color: String
    let engine: CarEngine
    private let transmission: String
    private let seats: Int
    private let doors: Int
    private let maxSpeed: Int
    private let fuelType: String
    private let price: Double
    var year: Int
    
    init(brand: String, color: String, engine: CarEngine, transmission: String, seats: Int, doors: Int, maxSpeed: Int, fuelType: String, price: Double, year: Int) {
        self.brand = brand
        self.color = color
        self.engine = engine
        self.transmission = transmission
        self.seats = seats
        self.doors = doors
        self.maxSpeed = maxSpeed
        self.fuelType = fuelType
        self.price = price
        self.year = year
    }
    
    required init(copyFrom prototype: Car) {
        self.brand = prototype.brand
        self.color = prototype.color
        self.engine = prototype.engine.clone()
        self.transmission = prototype.transmission
        self.seats = prototype.seats
        self.doors = prototype.doors
        self.maxSpeed = prototype.maxSpeed
        self.fuelType = prototype.fuelType
        self.price = prototype.price
        self.year = prototype.year
    }
    
    func clone() -> Self {
        return Self.init(copyFrom: self)
    }
    // other methods
}

class CarSubclass: Car {
    override func clone() -> Self /* CarSubclass */ {
        super.clone() // Retorna "Car()"
    }
}
