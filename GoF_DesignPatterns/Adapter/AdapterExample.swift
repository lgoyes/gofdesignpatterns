//
//  AdapterExample.swift
//  GoF_DesignPatterns
//
//  Created by Luis David Goyes Garces on 9/1/25.
//

class Sansa {
    let musicPlayer: MusicPlayer
    
    init(musicPlayer: MusicPlayer) {
        self.musicPlayer = musicPlayer
    }
    
    func main() {
        let playing = musicPlayer.playSong(fileName: "song.mp3")
        print(playing)
    }
}

protocol MusicPlayer {
    func playSong(fileName: String) -> String
}

class BasicPlayer: MusicPlayer {
    func playSong(fileName: String) -> String {
        "Playing MP3 file: \(fileName)"
    }
}

final class AdvancedPlayer {
    func playMP3(fileName: String) -> String {
        "Playing MP3 file: \(fileName)"
    }
    
    func playMP4(fileName: String) -> String {
        "Playing MP4 file: \(fileName)"
    }
}

class AdvancedPlayerAdapter: MusicPlayer {
    let adaptee: AdvancedPlayer
    init(adaptee: AdvancedPlayer) {
        self.adaptee = adaptee
    }
    
    func playSong(fileName: String) -> String {
        adaptee.playMP3(fileName: fileName)
    }
}

class SansaFactory {
    func create() -> Sansa {
        let player = AdvancedPlayer()
        let adapter = AdvancedPlayerAdapter(adaptee: player)
        let result = Sansa(musicPlayer: adapter)
        return result
    }
}
