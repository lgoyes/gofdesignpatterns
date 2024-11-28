//
//  KVO.swift
//  GoF_DesignPatterns
//
//  Created by Luis David Goyes Garces on 28/11/24.
//

class SomeSubject: NSObject {
    @objc dynamic var name: String
    
    init(name: String) {
        self.name = name
    }
}

class SomeObserver: NSObject {
    var result: String?
    
    override func observeValue(
        forKeyPath keyPath: String?,
        of object: Any?,
        change: [NSKeyValueChangeKey : Any]?,
        context: UnsafeMutableRawPointer?) {
            
        guard let keyPath = keyPath,  let change = change else {
            return
        }
        
        if let newName = change[NSKeyValueChangeKey.newKey],
            let oldName = change[NSKeyValueChangeKey.oldKey] {
            
            result = "La propiedad con el keyPath '\(keyPath)' antes era \(oldName) y ahora tiene el valor \(newName)"
        }
    }
}
