//
//  GameTemplateMethod.swift
//  GoF_DesignPatterns
//
//  Created by Luis David Goyes Garces on 27/1/25.
//

protocol Loader {
    func load()
}

class GameLoader: Loader {
    final func load() {
        releaseResources()
        loadPlayer()
        loadMap()
        if areThereAnyEnemies() {
            loadEnemies()
        }
        gameDidLoad()
    }
    
    func gameDidLoad() {
        
    }
    
    func loadPlayer() {
        fatalError("This method should be overriden")
    }
    
    func loadMap() {
        fatalError("This method should be overriden")
    }
    
    func areThereAnyEnemies() -> Bool {
        true
    }
    
    func releaseResources() {
        print("Releasing not needed resources...")
    }
    
    func loadEnemies() {
        print("Loading enemies...")
    }
}

class GhostOfTsushimaLoader: GameLoader {
    override func loadPlayer() {
        print("Loading armor...")
        print("Loading katana...")
        print("Loading techniques...")
    }
    
    override func loadMap() {
        print("Loading trees...")
        print("Loading animals...")
        print("Loading landscapes...")
    }
    
    override func areThereAnyEnemies() -> Bool {
        false
    }
}

class DoomLoader: GameLoader {
    
    override func loadPlayer() {
        print("Loading armor...")
        print("Loading weapons...")
        print("Loading power-ups...")
    }
    
    override func loadMap() {
        print("Loading installation...")
        print("Loading explosive barrels...")
        print("Loading mini map...")
    }
}

class HaloLoader: GameLoader {
    override func loadPlayer() {
        
    }
    override func loadMap() {
        
    }
}


fileprivate class Client {
    func main () {
        let got = createGoTLoader()
        got.load()
    }
    func createGoTLoader() -> Loader {
        GhostOfTsushimaLoader()
    }
}
