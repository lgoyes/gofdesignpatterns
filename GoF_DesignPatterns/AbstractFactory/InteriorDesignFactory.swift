//
//  InteriorDesignFactory.swift
//  GoF_DesignPatterns
//
//  Created by Luis David Goyes Garces on 13/12/24.
//

protocol Desk {
    func putLaptopOn()
}

protocol Library {
    func takeBook(_ name: String)
}

protocol InteriorDesignFactory {
    func makeDesk() -> Desk
    func makeLibrary() -> Library
}


class HabanoDesk: Desk {
    func putLaptopOn() {
        
    }
}

class HabanoLibrary: Library {
    func takeBook(_ name: String) {
        
    }
}

class HabanoInteriorDesignFactory: InteriorDesignFactory {
    func makeDesk() -> Desk {
        HabanoDesk()
    }
    
    func makeLibrary() -> Library {
        HabanoLibrary()
    }
}

class CenizaDesk: Desk {
    func putLaptopOn() {
        
    }
}

class CenizaLibrary: Library {
    func takeBook(_ name: String) {
        
    }
}

class CenizaInteriorDesignFactory: InteriorDesignFactory {
    func makeDesk() -> Desk {
        CenizaDesk()
    }
    
    func makeLibrary() -> Library {
        CenizaLibrary()
    }
}


class InteriorDesignClient {
    let factory: InteriorDesignFactory
    init(factory: InteriorDesignFactory) {
        self.factory = factory
    }
    
    func execute() {
        let desk = factory.makeDesk()
        desk.putLaptopOn()
        
        let library = factory.makeLibrary()
        library.takeBook("Domain Driven Design")
    }
}

class InteriorDesignClientFactory {
    func createClient() -> InteriorDesignClient {
        let factory = CenizaInteriorDesignFactory()
        return InteriorDesignClient(factory: factory)
    }
}
