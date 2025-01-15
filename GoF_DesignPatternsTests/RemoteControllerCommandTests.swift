//
//  RemoteControllerCommandTests.swift
//  GoF_DesignPatternsTests
//
//  Created by Luis David Goyes Garces on 14/1/25.
//

import Testing
@testable import GoF_DesignPatterns

class FakeCleaner: CleanerDriverAdapter {
    var mode: Cleaner.Mode
    var state: Cleaner.State
    init(mode: Cleaner.Mode, state: Cleaner.State) {
        self.mode = mode
        self.state = state
    }
    
    func getMode() -> Cleaner.Mode {
        mode
    }
    
    func getState() -> Cleaner.State {
        state
    }
    
    func set(mode: Cleaner.Mode) {
        self.mode = mode
    }
    
    func set(state: Cleaner.State) {
        self.state = state
    }
}

struct RemoteControllerCommandTests {

    @Test func basicBehavior() {
        let cleaner = FakeCleaner(mode: .all, state: .off)
        let sut = VacuumHouseCommand(cleaner: cleaner)
        sut.execute()
        #expect(cleaner.mode == .vacuum)
    }

}
