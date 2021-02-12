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


class AudioPlayer: ObservableObject {
    
    var audioPlayer: AVAudioPlayer!
    
    let objectWillChange = PassthroughSubject<AudioPlayer, Never>()
    
    var isPlaying = false {
        didSet {
            objectWillChange.send(self)
        }
    }
    
    func startPlayback (audio: URL) {
        
        
    }
    
}

