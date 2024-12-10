//
//  Motorcycle.swift
//  GoF_DesignPatterns
//
//  Created by Luis David Goyes Garces on 3/12/24.
//

class Engine {
    
}

class Wheel {
    
}

protocol Motorcycle {
    func move() -> String
}

class TimeMeasure {
    func start() {}
    func stop() {}
}

class Logger {
    func log(message: String) {}
}

class YamahaSZR150: Motorcycle {
    let engine: Engine
    let wheels: [Wheel]
    init(engine: Engine,
         wheels: [Wheel]) {
        self.engine = engine
        self.wheels = wheels
    }
    
    func move() -> String {
        let message = "YamahaSZR150 moving"
        return message
    }
}

class TimeMeasureDecorator: MotorcycleDecorator {
    private var timeMeasure = TimeMeasure()
    override func move() -> String {
        timeMeasure.start()
        let message = super.move()
        timeMeasure.stop()
        return message
    }
}

class LoggerDecorator: MotorcycleDecorator {
    private var logger = Logger()
    override func move() -> String {
        logger.log(message: "LoggerDecorator moved")
        return super.move()
    }
}

class MotorcycleDecorator: Motorcycle {
    private let wrapped: Motorcycle
    init(wrapped: Motorcycle) {
        self.wrapped = wrapped
    }
    func move() -> String {
        wrapped.move()
    }
}

class MotorcycleTrunk: MotorcycleDecorator {
    override func move() -> String {
        super.move() + " with trunk"
    }
}

class MotorcycleSliders: MotorcycleDecorator {
    override func move() -> String {
        super.move() + " with sliders"
    }
}
