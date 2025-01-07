//
//  SimpleFactory.swift
//  GoF_DesignPatterns
//
//  Created by Luis David Goyes Garces on 12/12/24.
//

protocol FactoryProductType {
    func doSomething()
}

class FactoryProduct: FactoryProductType {
    func doSomething() {}
}

class AnotherFactoryProduct: FactoryProduct {}

protocol FactoryType {
    func createProduct() -> FactoryProductType
}

class Factory: FactoryType {
    private static let instance = Factory()
    init() {}
    
    func createProduct()
    -> FactoryProductType { FactoryProduct()}
    
    static func getInstance() -> FactoryType {
        instance
    }
}
class FactoryClient {
    let factory: FactoryType
    init(factory: FactoryType) {
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
