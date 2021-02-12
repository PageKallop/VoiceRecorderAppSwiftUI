//
//  RecordingList.swift
//  VoiceRecorderAppSwiftUI
//
//  Created by Page Kallop on 2/10/21.
//

import SwiftUI

struct RecordingList: View {
    
    @ObservedObject var audioRecorder: AudioRecorder
    
    var body: some View {
       //creates recording list 
        List {
           
            ForEach(audioRecorder.recordings, id: \.createdAt) { recording in
                RecordingRow(audioURL: recording.fileURL)
            }
        }
    }
}

struct RecordingRow: View {
    
    var audioURL: URL
    
    @ObservedObject var audioPlayer = AudioPlayer()
    
    var body: some View {
        
        HStack {
            Text("\(audioURL.lastPathComponent)")
            Spacer()
            //creates start/stop button
            if audioPlayer.isPlaying == false {
                Button(action: {
                    print("play")
                }) {
                    Image(systemName: "play.circle")
                        .imageScale(.large)
                }
            } else {
                Button(action: {
                    print("Stop")
                }) {
                    Image(systemName: "stop.fill")
                        .imageScale(.large)
                }
            }
        }
    }
}

struct RecordingList_Previews: PreviewProvider {
    static var previews: some View {
        RecordingList(audioRecorder: AudioRecorder())
    }
}
