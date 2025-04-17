//
//  FlyweightExample.swift
//  GoF_DesignPatterns
//
//  Created by Luis David Goyes Garces on 16/4/25.
//

import Foundation

class FlyweightExample {
    
    struct Color {
        
    }
    
    class CharacterFlyweight {
        let color: Color
        let sprite: Data
        init(color: Color, sprite: Data) {
            self.color = color
            self.sprite = sprite
        }
        func draw(x: Int, y: Int, direction: Int) {
            // Some drawing code
        }
    }
    
    class CharacterContext {
        var x: Int
        var y: Int
        var direction: Int
        var repeatingState: CharacterFlyweight
        init(x: Int, y: Int, direction: Int, repeatingState: CharacterFlyweight) {
            self.x = x
            self.y = y
            self.direction = direction
            self.repeatingState = repeatingState
        }
        
        func draw() {
            repeatingState.draw(x: x, y: y, direction: direction)
        }
    }
    
    class CharacterFlyweightFactory {
        private static var instances: [String: CharacterFlyweight] = [:]
        
        static func getOrCreate(color: Color, spriteName: String) -> CharacterFlyweight {
            if let instance = Self.instances[spriteName] {
                return instance
            }
            let result = CharacterFlyweight(color: color, sprite: Data())
            instances[spriteName] = result
            return result
        }
    }
    
    
}
