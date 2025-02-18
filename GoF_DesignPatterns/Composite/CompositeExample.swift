//
//  CompositeExample.swift
//  GoF_DesignPatterns
//
//  Created by Luis David Goyes Garces on 18/2/25.
//


protocol Boxable {
    func description() -> String
    func price() -> Double
}

class Receipt: Boxable {
    func description() -> String {
        "This is the receipt"
    }
    func price() -> Double {
        0
    }
}

class iPhone11: Boxable {
    func description() -> String {
        "iPhone 11"
    }
    func price() -> Double {
        1000
    }
}

class iPhoneCharger: Boxable {
    func description() -> String {
        "Some generic charger"
    }
    func price() -> Double {
        10
    }
}

class SonyWH1000xm4: Boxable {
    func description() -> String {
        "Sony WH1000 xm4"
    }
    func price() -> Double {
        200
    }
}

class Box: Boxable {
    private var products: [Boxable]
    init(products: [Boxable]) {
        self.products = products
    }
    
    func description() -> String {
        "Box with: \(products.map({ "\($0.description())" }).joined(separator: " ")). "
    }
    func price() -> Double {
        boxPrice() + itemsPrice()
    }
    private func itemsPrice() -> Double {
        products.reduce(0, { $0 + $1.price() })
    }
    func boxPrice() -> Double {
        1
    }
}
