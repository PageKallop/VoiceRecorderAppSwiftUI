//
//  AudioPlayer.swift
//  VoiceRecorderAppSwiftUI
//
//  Created by Page Kallop on 2/12/21.
//

import Foundation
import SwiftUI
import Combine
import AVFoundation


class AudioPlayer: NSObject, ObservableObject, AVAudioPlayerDelegate {
    
    var audioPlayer: AVAudioPlayer!
    
    let objectWillChange = PassthroughSubject<AudioPlayer, Never>()
    
    var isPlaying = false {
        didSet {
            objectWillChange.send(self)
        }
    }
    
    func startPlayback (audio: URL) {
        
        let playBackSession = AVAudioSession.sharedInstance()
        //overwrites output to speakers
        do {
            try playBackSession.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
        } catch {
            print("Playing over speakers failed")
        }
        //plays audio 
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audio)
            audioPlayer.delegate = self
            audioPlayer.play()
            isPlaying = true
        
        } catch {
            print("Playback failed")
        }
    }
    //stops audio playback
    func stopPlayback() {
        
        audioPlayer.stop()
        isPlaying = false
    }
    
    //notifies when audio finishes playing 
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            isPlaying = false
        }
    }
}

