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
    let cleaner: XiaomiS20CleanerDriver
    private var previousMode: XiaomiS20CleanerDriver.Mode = .all
    private var previousState: XiaomiS20CleanerDriver.State = .off
    
    init(cleaner: XiaomiS20CleanerDriver) {
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
        result.set(command: VacuumHouseCommand(cleaner: cleaner), at: 4)
        result.set(command: MopFloorCommand(cleaner: cleaner), at: 5)
        result.set(command: TurnCleanerOffCommand(cleaner: cleaner), at: 6)
        
        let blind = BlindDriver()
        result.set(command: OpenBlindCommand(blind: blind), at: 7)
        result.set(command: CloseBlindCommand(blind: blind), at: 8)
        
        let lamp = LampDriver()
        result.set(command: TurnLampOnCommand(lamp: lamp), at: 9)
        result.set(command: TurnLampOffCommand(lamp: lamp), at: 10)
        
        let wakeupCommand = MacroCommand(commands: [
            VacuumHouseCommand(cleaner: cleaner),
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
