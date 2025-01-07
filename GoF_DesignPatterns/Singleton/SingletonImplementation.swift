//
//  SingletonImplementation.swift
//  GoF_DesignPatterns
//
//  Created by Luis David Goyes Garces on 20/12/24.
//

protocol CEOProtocol {
    func greet() -> String
}

class CEO {
    let name: String
    let company: String
    let dependency = SomeDependency()
    
    private static var instance: CEO!
    
    init (name: String, company: String) {
        self.name = name
        self.company = company
    }
    
    static func getInstance() -> CEO {
        if instance == nil {
            instance = CEO(name: "David", company: "GoF Design Patterns")
        }
        return instance
    }
    
    func greet() -> String {
        "Hello, my name is \(name), I am the Chief Executive Officer of \(company)"
    }
    
    // XXX: ATENCION: Solo se puede usar con fines de automatización de pruebas
    static func set(testingInstance: CEO) {
        instance = testingInstance
    }
}

class Company {
    func greetingsFromCEO() -> String {
        "CEO says: \(CEO.getInstance().greet())"
    }
}

class SomeDependency {}

protocol SingletonProvidable {
    func provideCEO() -> CEOProtocol
}
class SingletonProvider: SingletonProvidable {
    func provideCEO() -> CEOProtocol {
        CEO.getInstance() as! CEOProtocol
    }
}

class SendEmailToEmployeesUseCase {
    let singletonProvider: SingletonProvidable
    init(singletonProvider: SingletonProvidable) {
        self.singletonProvider = singletonProvider
    }
    
    func execute() {
        let ceo = singletonProvider.provideCEO()
        let message = ceo.greet()
        print(message)
    }
}
