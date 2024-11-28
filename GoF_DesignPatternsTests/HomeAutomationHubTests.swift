//
//  HomeAutomationHubTests.swift
//  GoF_DesignPatternsTests
//
//  Created by Luis David Goyes Garces on 27/11/24.
//

import Testing
@testable import GoF_DesignPatterns

class TestingFan: Fan {
    var active = false
    override func activate() {
        active = true
    }
}

class TestingSirenAlarm: SirenAlarm {
    var active = false
    override func activate() {
        active = true
    }
}

struct HomeAutomationHubTests {

    @Test func basicFunctionality() {
        let sut = HomeAutomationHub()

        let fan = GIVEN_someFan(sut)
        let siren = GIVEN_someSiren(sut)
        
        WHEN_doorOpened(sut)
        
        THEN_sirenShouldBeActive(siren)
        THEN_fanShouldNotBeActive(fan)
    }
    
    func GIVEN_someFan(_ sut: HomeAutomationHub)
    -> TestingFan {
        let fan = TestingFan(dataSource: sut)
        sut.add(device: fan)
        return fan
    }
    
    func GIVEN_someSiren(_ sut: HomeAutomationHub)
    -> TestingSirenAlarm {
        let siren = TestingSirenAlarm(dataSource: sut)
        sut.add(device: siren)
        return siren
    }
    
    func WHEN_doorOpened(_ sut: HomeAutomationHub) {
        sut.openFrontDoor()
    }
    
    func THEN_sirenShouldBeActive(_ siren: TestingSirenAlarm) {
        #expect(siren.active)
    }
    
    func THEN_fanShouldNotBeActive(_ fan: TestingFan) {
        #expect(!fan.active)
    }
}
