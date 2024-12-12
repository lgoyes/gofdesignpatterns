//
//  SimpleFactory.swift
//  GoF_DesignPatterns
//
//  Created by Luis David Goyes Garces on 12/12/24.
//

class FactoryProduct {
    func doSomething() {}
}
class AnotherFactoryProduct: FactoryProduct {}

class Factory {
    private static let instance = Factory()
    private init() {}
    
    func createProduct()
    -> FactoryProduct { FactoryProduct()}
    
    static func getInstance() -> Factory {
        instance
    }
}
class FactoryClient {
    let factory: Factory
    init(factory: Factory) {
        self.factory = factory
    }
    
    func main() {
        let product = factory.createProduct()
        product.doSomething()
    }
}

class FactoryClientClient {
    func create() {
        let factory = Factory.getInstance()
        let factoryClient = FactoryClient(factory: factory)
        factoryClient.main()
    }
}
