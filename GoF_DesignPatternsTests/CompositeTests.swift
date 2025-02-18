//
//  CompositeTests.swift
//  GoF_DesignPatternsTests
//
//  Created by Luis David Goyes Garces on 18/2/25.
//

import Testing
@testable import GoF_DesignPatterns

struct CompositeTests {
    
    func getProduct() -> Boxable {
        let iphone = iPhone11()
        let charger = iPhoneCharger()
        let iphoneBox = Box(products: [iphone, charger])
        
        let iPhoneReceipt = Receipt()
        let iPhoneBoxWithReceipt = Box(products: [iphoneBox, iPhoneReceipt])
        
        let headphones = SonyWH1000xm4()
        let headphonesReceipt = Receipt()
        let headphonesBox = Box(products: [headphones, headphonesReceipt])
        
        let result = Box(products: [iPhoneBoxWithReceipt, headphonesBox])
        
        return result
    }

    @Test func description() {
        let finalBox = getProduct()
        let expectedResult = "Box with: Box with: Box with: iPhone 11 Some generic charger.  This is the receipt.  Box with: Sony WH1000 xm4 This is the receipt. . "
        #expect(finalBox.description() == expectedResult)
    }
    
    @Test func price() {
        let finalBox = getProduct()
        let expectedResult = 1214.0
        #expect(finalBox.price() == expectedResult)
    }

}
