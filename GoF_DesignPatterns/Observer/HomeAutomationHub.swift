//
//  HomeAutomationHub.swift
//  GoF_DesignPatterns
//
//  Created by Luis David Goyes Garces on 27/11/24.
//

protocol RoomTemperatureRetriever: AnyObject {
    func getRoomTemperature() -> Int
}

extension HomeAutomationHub: RoomTemperatureRetriever {
    func getRoomTemperature() -> Int {
        roomTemperature
    }
}


protocol DoorStateRetriever: AnyObject {
    func getFrontDoorOpen() -> Bool
}

extension HomeAutomationHub: DoorStateRetriever {
    func getFrontDoorOpen() -> Bool {
        frontDoorOpen
    }
}

class HomeAutomationHub {
    private var frontDoorOpen: Bool
    private var roomTemperature: Int
    
    private var devices: [Device]
    
    init() {
        self.frontDoorOpen = false
        self.roomTemperature = 0
        self.devices = []
    }
    
    func add(device: Device) {
        devices.append(device)
    }
    
    func remove(device: Device) {
        devices.removeAll(
            where: { $0 === device })
    }
    
    private func notifyDevices() {
        devices.forEach {
            $0.sensorsChanged()
        }
    }
    
    func closeFrontDoor() {
        self.frontDoorOpen = false
        notifyDevices()
    }
    
    func openFrontDoor() {
        self.frontDoorOpen = true
        notifyDevices()
    }
    
    func setRoom(temperature: Int) {
        self.roomTemperature = temperature
        notifyDevices()
    }
}

protocol Device: AnyObject {
    func sensorsChanged()
}

class Fan: Device {
    private let dataSource: RoomTemperatureRetriever
    init(dataSource: RoomTemperatureRetriever) {
        self.dataSource = dataSource
    }
    
    func sensorsChanged() {
        if dataSource.getRoomTemperature() > 25 {
            activate()
        }
    }
    
    func activate() {
        print("Fan activated")
    }
}

class SirenAlarm: Device {
    private let dataSource: DoorStateRetriever
    private var previousFrontDoorOpen = false

    init(dataSource: DoorStateRetriever) {
        self.dataSource = dataSource
    }
        
    func sensorsChanged() {
        let frontDoorOpen = dataSource.getFrontDoorOpen()
        if previousFrontDoorOpen != frontDoorOpen
            && frontDoorOpen {
            activate()
        }
        previousFrontDoorOpen = frontDoorOpen
    }
    
    func activate() {
        print("Siren activated")
    }
}
