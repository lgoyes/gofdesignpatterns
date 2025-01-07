//
//  FactoryTests.swift
//  GoF_DesignPatternsTests
//
//  Created by Luis David Goyes Garces on 13/12/24.
//

import Testing
@testable import GoF_DesignPatterns

class FakeFactoryProduct: FactoryProductType {
    var doSomethingCalled = false
    func doSomething() {
        doSomethingCalled = true
    }
}

class FakeFactory: FactoryType {
    let product: FakeFactoryProduct
    init(product: FakeFactoryProduct) {
        self.product = product
    }
    func createProduct() -> FactoryProductType {
        product
    }
}

struct FactoryTests {

    @Test func abstractFactory() {
        let product = FakeFactoryProduct()
        let factory = FakeFactory(product: product)
        let sut = FactoryClient(factory: factory)
        sut.main()
        #expect(product.doSomethingCalled)
    }

}
