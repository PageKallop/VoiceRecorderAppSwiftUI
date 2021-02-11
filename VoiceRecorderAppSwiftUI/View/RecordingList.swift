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
    
    var body: some View {
        
        HStack {
            Text("\(audioURL.lastPathComponent)")
            Spacer()
        }
    }
}

struct RecordingList_Previews: PreviewProvider {
    static var previews: some View {
        RecordingList(audioRecorder: AudioRecorder())
    }
}
