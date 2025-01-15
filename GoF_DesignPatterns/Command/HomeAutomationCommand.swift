//
//  HomeAutomationCommand.swift
//  GoF_DesignPatterns
//
//  Created by Luis David Goyes Garces on 7/1/25.
//

final class FanDriver {
    enum Speed {
        case low, medium, high
    }
    enum State {
        case off, on
    }
    
    private var speed: Speed
    private var state: State
    
    init(speed: Speed = .low, state: State = .off) {
        self.speed = speed
        self.state = state
    }
    
    func getSpeed() -> Speed { speed }
    func isOn() -> Bool { state == .on }
    func set(speed: Speed) { self.speed = speed }
    func turnOn() { state = .on }
    func turnOff() { state = .off }
}

enum Cleaner {
    enum Mode {
        case vacuum, mop, all
    }
    enum State {
        case off, charging, idle, cleaning
    }
}

protocol CleanerDriverAdapter {
    func getMode() -> Cleaner.Mode
    func getState() -> Cleaner.State
    func set(mode: Cleaner.Mode)
    func set(state: Cleaner.State)
}

class XiaomiS20CleanerDriverModeMapper {
    func map(_ mode: XiaomiS20CleanerDriver.Mode) -> Cleaner.Mode {
        switch mode {
        case .vacuum:
            return .vacuum
        case .mop:
            return .mop
        case .all:
            return .all
        }
    }
    
    func invert(_ mode: Cleaner.Mode) -> XiaomiS20CleanerDriver.Mode {
        switch mode {
        case .vacuum:
            return .vacuum
        case .mop:
            return .mop
        case .all:
            return .all
        }
    }
}

class XiaomiS20CleanerDriverStateMapper {
    func map(_ state: XiaomiS20CleanerDriver.State) -> Cleaner.State {
        switch state {
        case .off:
            return .off
        case .charging:
            return .charging
        case .idle:
            return .idle
        case .cleaning:
            return .cleaning
        }
    }
    func invert(_ state: Cleaner.State) -> XiaomiS20CleanerDriver.State {
        switch state {
        case .off:
            return .off
        case .charging:
            return .charging
        case .idle:
            return .idle
        case .cleaning:
            return .cleaning
        }
    }
}

class XiaomiS20CleanerDriverAdapter: CleanerDriverAdapter {
    private let adaptee: XiaomiS20CleanerDriver
    private let modeMapper: XiaomiS20CleanerDriverModeMapper
    private let stateMapper: XiaomiS20CleanerDriverStateMapper
    
    init(adaptee: XiaomiS20CleanerDriver, modeMapper: XiaomiS20CleanerDriverModeMapper, stateMapper: XiaomiS20CleanerDriverStateMapper) {
        self.adaptee = adaptee
        self.modeMapper = modeMapper
        self.stateMapper = stateMapper
    }
    
    func getMode() -> Cleaner.Mode {
        let mode = adaptee.getMode()
        return modeMapper.map(mode)
    }
    
    func getState() -> Cleaner.State {
        let state = adaptee.getState()
        return stateMapper.map(state)
    }
    
    func set(mode: Cleaner.Mode) {
        adaptee.set(mode: modeMapper.invert(mode))
    }

    func set(state: Cleaner.State) {
        adaptee.set(state: stateMapper.invert(state))
    }
}

final class XiaomiS20CleanerDriver {
    enum Mode {
        case vacuum, mop, all
    }
    enum State {
        case off, charging, idle, cleaning
    }
    
    private var mode: Mode
    private var state: State
    
    init(mode: Mode = .vacuum, state: State = .off) {
        self.mode = mode
        self.state = state
    }
    
    func getMode() -> Mode { mode }
    func getState() -> State { state }
    func set(mode: Mode) { self.mode = mode }
    func set(state: State) { self.state = state}
}

final class BlindDriver {
    private var heightLevel: Int
    init(heightLevel: Int = 0) {
        self.heightLevel = heightLevel
    }
    func getHeight() -> Int { heightLevel }
    func set(height: Int) { self.heightLevel = height }
}

final class LampDriver {
    enum State {
        case off, on
    }
    private var state: State
    init(state: State = .off) {
        self.state = state
    }
    func isOn() -> Bool { self.state == .on }
    func turnOn() { state = .on }
    func turnOff() { state = .off }
}

protocol Command {
    func execute()
    func undo()
}

class MacroCommand: Command {
    private var commands: [Command]
    
    init(commands: [Command]) {
        self.commands = commands
    }
    
    func execute() {
        commands.forEach { $0.execute() }
    }
    
    func undo() {
        commands.reversed().forEach { $0.undo() }
    }
}

class SetFanSpeedCommand: Command {
    let fan: FanDriver
    private var previousState: FanDriver.State = .off
    private var previousSpeed: FanDriver.Speed = .low
    
    init(fan: FanDriver) {
        self.fan = fan
    }
    
    func execute() {
        storePreviousFanState()
        
    }
    
    private func storePreviousFanState() {
        previousState = fan.isOn() ? .on : .off
        previousSpeed = fan.getSpeed()
    }
    
    func undo() {
        if previousState == .on {
            fan.turnOn()
        } else {
            fan.turnOff()
        }
        fan.set(speed: previousSpeed)
    }
}

class SetFanSpeedToLowCommand: SetFanSpeedCommand {
    override func execute() {
        super.execute()
        fan.turnOn()
        fan.set(speed: .low)
    }
}

class SetFanSpeedToMediumCommand: SetFanSpeedCommand {
    override func execute() {
        super.execute()
        fan.turnOn()
        fan.set(speed: .medium)
    }
}

class SetFanSpeedToHighCommand: SetFanSpeedCommand {
    override func execute() {
        super.execute()
        fan.turnOn()
        fan.set(speed: .high)
    }
}

class TurnFanOffCommand: SetFanSpeedCommand {
    override func execute() {
        super.execute()
        fan.turnOff()
    }
}

class CleanHouseCommand: Command {
    let cleaner: CleanerDriverAdapter
    private var previousMode: Cleaner.Mode = .all
    private var previousState: Cleaner.State = .off
    
    init(cleaner: CleanerDriverAdapter) {
        self.cleaner = cleaner
    }
    
    func execute() {
        storePreviousState()
    }
    
    private func storePreviousState() {
        previousMode = cleaner.getMode()
        previousState = cleaner.getState()
    }
    
    func undo() {
        cleaner.set(mode: previousMode)
        cleaner.set(state: previousState)
    }
}

class VacuumHouseCommand: CleanHouseCommand {
    override func execute() {
        super.execute()
        cleaner.set(mode: .vacuum)
        cleaner.set(state: .cleaning)
    }
}

class MopFloorCommand: CleanHouseCommand {
    override func execute() {
        super.execute()
        cleaner.set(mode: .mop)
        cleaner.set(state: .cleaning)
    }
}

class TurnCleanerOffCommand: CleanHouseCommand {
    override func execute() {
        super.execute()
        cleaner.set(state: .off)
    }
}

class BlindCommand: Command {
    let blind: BlindDriver
    var previousHeight = 0
    
    init(blind: BlindDriver) {
        self.blind = blind
    }
    
    func execute() {
        storePreviousState()
    }
    
    private func storePreviousState() {
        previousHeight = blind.getHeight()
    }
    
    func undo() {
        blind.set(height: previousHeight)
    }
}

class OpenBlindCommand: BlindCommand {
    override func execute() {
        super.execute()
        blind.set(height: 100)
    }
}

class CloseBlindCommand: BlindCommand {
    override func execute() {
        super.execute()
        blind.set(height: 0)
    }
}

class TurnLampOnCommand: Command {
    private let lamp: LampDriver
    init(lamp: LampDriver) {
        self.lamp = lamp
    }
    
    func execute() {
        lamp.turnOn()
    }
    
    func undo() {
        lamp.turnOff()
    }
}

class TurnLampOffCommand: Command {
    private let lamp: LampDriver
    init(lamp: LampDriver) {
        self.lamp = lamp
    }
    
    func execute() {
        lamp.turnOff()
    }
    
    func undo() {
        lamp.turnOn()
    }
}

class NullCommand: Command {
    func undo() {}
    func execute() {}
}

class RemoteController {
    private var commands: [Command]
    private var lastCommand: Command
    
    init(numberOfSlots: Int) {
        self.commands = Array(repeating: NullCommand(), count: numberOfSlots)
        self.lastCommand = NullCommand()
    }
    
    func pressButton(at index: Int) {
        validate(slot: index)
        commands[index].execute()
    }
    
    func set(command: Command, at index: Int) {
        validate(slot: index)
        commands[index] = command
    }
    
    func removeCommand(at index: Int) {
        validate(slot: index)
        commands[index] = NullCommand()
    }
    
    func validate(slot index: Int) {
        precondition(index >= 0 && index < commands.count, "Invalid slots!")
    }
    
    func undo() {
        lastCommand.undo()
        lastCommand = NullCommand()
    }
}

class RemoteControllerFactory {
    func create() -> RemoteController {
        let result = RemoteController.init(numberOfSlots: 12)
        
        let fan = FanDriver()
        result.set(command: SetFanSpeedToLowCommand(fan: fan), at: 0)
        result.set(command: SetFanSpeedToMediumCommand(fan: fan), at: 1)
        result.set(command: SetFanSpeedToHighCommand(fan: fan), at: 2)
        result.set(command: TurnFanOffCommand(fan: fan), at: 3)
        
        let cleaner = XiaomiS20CleanerDriver()
        let cleanerModeMapper = XiaomiS20CleanerDriverModeMapper()
        let cleanerStateMapper = XiaomiS20CleanerDriverStateMapper()
        let cleanerAdapter = XiaomiS20CleanerDriverAdapter(adaptee: cleaner, modeMapper: cleanerModeMapper, stateMapper: cleanerStateMapper)

        result.set(command: VacuumHouseCommand(cleaner: cleanerAdapter), at: 4)
        result.set(command: MopFloorCommand(cleaner: cleanerAdapter), at: 5)
        result.set(command: TurnCleanerOffCommand(cleaner: cleanerAdapter), at: 6)
        
        let blind = BlindDriver()
        result.set(command: OpenBlindCommand(blind: blind), at: 7)
        result.set(command: CloseBlindCommand(blind: blind), at: 8)
        
        let lamp = LampDriver()
        result.set(command: TurnLampOnCommand(lamp: lamp), at: 9)
        result.set(command: TurnLampOffCommand(lamp: lamp), at: 10)
        
        let wakeupCommand = MacroCommand(commands: [
            VacuumHouseCommand(cleaner: cleanerAdapter),
            OpenBlindCommand(blind: blind),
            SetFanSpeedToHighCommand(fan: fan),
        ])
        result.set(command: wakeupCommand, at: 11)
        
        return result
    }
}

class RemoteControllerClient {
    func main() {
        let remoteController = RemoteControllerFactory().create()
        remoteController.pressButton(at: 0)
    }
}
