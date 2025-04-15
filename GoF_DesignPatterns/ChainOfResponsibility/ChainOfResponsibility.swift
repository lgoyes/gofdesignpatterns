//
//  ChainOfResponsibility.swift
//  GoF_DesignPatterns
//
//  Created by Luis David Goyes Garces on 15/4/25.
//

struct Passport {
    let passportNumber: String
    let fullName: String
    let nationality: String
}

struct BoardingPass {
    let passengerName: String
    let flightNumber: String
    let departureDate: Date
    let seatNumber: String
}

struct ChainRequest {
    let passport: Passport
    let boardingPass: BoardingPass
}

protocol ChainHandler {
    func handle(_ request: ChainRequest) throws
}

class BaseChainHandler: ChainHandler {
    private var nextHandler: ChainHandler?
    
    init(nextHandler: ChainHandler? = nil) {
        self.nextHandler = nextHandler
    }
    
    func set(nextHandler: ChainHandler?) {
        self.nextHandler = nextHandler
    }
    
    func handle(_ request: ChainRequest) throws {
        if let nextHandler = nextHandler {
            try nextHandler.handle(request)
        }
    }
}

class FirstSecurityControl: BaseChainHandler {
    enum Error: Swift.Error {
        case passportAndBoardingPassDoNotMatch
    }
    override func handle(_ request: ChainRequest) throws {
        guard doPassportAndBoardingPassMatch(request) else {
            throw Error.passportAndBoardingPassDoNotMatch
        }
        try super.handle(request)
    }
    
    func doPassportAndBoardingPassMatch(_ request: ChainRequest) -> Bool {
        request.boardingPass.passengerName == request.passport.fullName
    }
}

class SecondSecurityControl: BaseChainHandler {
    enum Error: Swift.Error {
        case flightNotToday
    }
    override func handle(_ request: ChainRequest) throws {
        guard isFlightToday(request) else {
            throw Error.flightNotToday
        }
        try super.handle(request)
    }
    
    func isFlightToday(_ request: ChainRequest) -> Bool {
        Calendar.current.isDateInToday(request.boardingPass.departureDate)
    }
}

class ThirdSecurityControl: BaseChainHandler {
    enum Error: Swift.Error {
        case invalidNationality
    }
    override func handle(_ request: ChainRequest) throws {
        guard hasValidNationality(request) else {
            throw Error.invalidNationality
        }
        try super.handle(request)
    }
    func hasValidNationality(_ request: ChainRequest) -> Bool {
        request.passport.nationality == "CO"
    }
}

class SecurityControlFactory {
    func create() -> ChainHandler {
        let firstControl = FirstSecurityControl()
        let secondControl = SecondSecurityControl()
        let thirdControl = ThirdSecurityControl()
        
        firstControl.set(nextHandler: secondControl)
        secondControl.set(nextHandler: thirdControl)
        
        return firstControl
    }
}
