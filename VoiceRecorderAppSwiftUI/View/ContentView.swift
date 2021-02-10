//
//  ContentView.swift
//  VoiceRecorderAppSwiftUI
//
//  Created by Page Kallop on 2/10/21.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var audioRecorder: AudioRecorder
    
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(audioRecorder: AudioRecorder())
    }
}