//
//  AdapterExample.swift
//  GoF_DesignPatterns
//
//  Created by Luis David Goyes Garces on 9/1/25.
//

protocol VideoPlayer {
    func playVideo(fileName: String) -> String
    func executeSomethingElse()
    func recordVideo()
    func pauseVideo()
    func resumeVideo()
}

class SansaMP4Player {
    let videoPlayer: VideoPlayer
    init(videoPlayer: VideoPlayer) {
        self.videoPlayer = videoPlayer
    }
    func playVideo() {
        let playing = videoPlayer.playVideo(fileName: "somefilm.mp4")
        videoPlayer.executeSomethingElse()
        videoPlayer.pauseVideo()
        videoPlayer.pauseVideo()
        videoPlayer.resumeVideo()
        print(playing)
    }
}

class Sansa {
    static func playSong(musicPlayer: MusicPlayer) {
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
