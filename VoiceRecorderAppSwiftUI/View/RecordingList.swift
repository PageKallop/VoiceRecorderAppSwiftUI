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
            Text("Empty list")
        }
    }
}

struct RecordingList_Previews: PreviewProvider {
    static var previews: some View {
        RecordingList(audioRecorder: AudioRecorder())
    }
}
