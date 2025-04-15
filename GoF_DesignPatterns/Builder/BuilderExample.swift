//
//  BuilderExample.swift
//  GoF_DesignPatterns
//
//  Created by Luis David Goyes Garces on 10/4/25.
//

struct Leg {
    let origin: String
    let destination: String
}

struct Flight {
    let number: Int
    let airline: String
    let legs: [Leg]
}

class LegBuilder {
    var origin: String = ""
    var destination: String = ""
    func build() -> Leg {
        Leg(origin: origin, destination: destination)
    }
}

class FlightBuilder {
    var number: Int = 0
    var airline: String = ""
    var legs: [LegBuilder] = []
    func build() -> Flight {
        Flight(number: number, airline: airline, legs: legs.map({ $0.build() }))
    }
}


class CounterWrapper {
    private var counter = 0
    func increaseCounter() {
        counter += 1
    }
    func getCounter() -> Int {
        counter
    }
}

class RegularEvent {
    private var name: String = "", location: String?
    private var start: Date?, end: Date?
    
    func set(name: String) {
        self.name = name
    }
    
    func getName() -> String {
        name
    }
    
    func set(location: String?) {
        self.location = location
    }
    
    func getLocation() -> String? {
        location
    }
    
    func set(start: Date?) {
        self.start = start
    }
    
    func getStart() -> Date? {
        start
    }
    
    func set(end: Date?) {
        self.end = end
    }
    
    func getEnd() -> Date? {
        end
    }
}

class FluentEvent {
    private var name: String, location: String?
    private var start: Date?, end: Date?
    private let formatter = DateFormatter()
    
    init(name: String) {
        self.name = name
    }
    
    @discardableResult
    func on(year: Int, month: Int, day: Int) -> FluentEvent {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day

        start = Calendar.current.date(from: dateComponents)
        end = start
        return self
    }
    
    @discardableResult
    func from(startTime: String) -> FluentEvent {
        start = combine(date: start, withTime: startTime)
        return self
    }
    
    @discardableResult
    func to(startTime: String) -> FluentEvent {
        end = combine(date: end, withTime: startTime)
        return self
    }
    
    @discardableResult
    func at(location: String) -> FluentEvent {
        self.location = location
        return self
    }
    
    private func parse(time: String) -> Date? {
        formatter.dateFormat = "HH:mm"
        return formatter.date(from: time)
    }
    
    private func combine(date: Date?, withTime time: String) -> Date? {
        guard let baseDate = date else {
            return nil
        }

        guard let timeOnly = parse(time: time) else {
            return nil
        }
        
        let calendar = Calendar.current
        let timeComponents = calendar.dateComponents([.hour, .minute], from: timeOnly)
        var fullComponents = calendar.dateComponents([.year, .month, .day], from: baseDate)
        fullComponents.hour = timeComponents.hour
        fullComponents.minute = timeComponents.minute
        
        return calendar.date(from: fullComponents)
    }
}

class EventExpressionBuilder {
    private let event: RegularEvent
    private let formatter = DateFormatter()

    init(name: String) {
        self.event = RegularEvent()
        self.event.set(name: name)
    }
    
    func getContent() -> RegularEvent {
        event
    }
    
    @discardableResult
    func on(year: Int, month: Int, day: Int) -> Self {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day

        let date = Calendar.current.date(from: dateComponents)
        event.set(start: date)
        event.set(end: date)
        return self
    }
    
    @discardableResult
    func from(startTime: String) -> Self {
        let updatedDate = combine(date: event.getStart(), withTime: startTime)
        event.set(start: updatedDate)
        return self
    }
    
    @discardableResult
    func to(endTime: String) -> Self {
        let updatedDate = combine(date: event.getEnd(), withTime: endTime)
        event.set(end: updatedDate)
        return self
    }
    
    @discardableResult
    func at(location: String) -> Self {
        event.set(location: location)
        return self
    }
    
    private func parse(time: String) -> Date? {
        formatter.dateFormat = "HH:mm"
        return formatter.date(from: time)
    }
    
    private func combine(date: Date?, withTime time: String) -> Date? {
        guard let baseDate = date else {
            return nil
        }

        guard let timeOnly = parse(time: time) else {
            return nil
        }
        
        let calendar = Calendar.current
        let timeComponents = calendar.dateComponents([.hour, .minute], from: timeOnly)
        var fullComponents = calendar.dateComponents([.year, .month, .day], from: baseDate)
        fullComponents.hour = timeComponents.hour
        fullComponents.minute = timeComponents.minute
        
        return calendar.date(from: fullComponents)
    }
}

class FluetClient {
    func main() {
        FluentEvent(name: "Estudiar Patrones")
            .at(location: "Casa")
            .on(year: 2025, month: 04, day: 10)
            .from(startTime: "18:00")
            .to(startTime: "20:00")
    }
}
