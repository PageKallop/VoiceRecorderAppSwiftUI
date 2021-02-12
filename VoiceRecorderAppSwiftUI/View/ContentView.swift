//
//  ContentView.swift
//  VoiceRecorderAppSwiftUI
//
//  Created by Page Kallop on 2/10/21.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var audioRecorder: AudioRecorder
    
    @State private var isPressed: Bool = false
    
    var body: some View {
        
        NavigationView{
        
        VStack {
           
            RecordingList(audioRecorder: audioRecorder)
            //creates start/stop recording button
            if audioRecorder.recording == false {
                Button(action: {self.audioRecorder.startRecording()}) {
                    Image(systemName: "circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 75, height: 75)
                         .clipped()
                        .overlay(
                            Circle().stroke(Color.gray, lineWidth: 4.0))
                        .foregroundColor(.red)
                        .padding(.bottom, 40)
                }
            } else {
                ZStack {
                    Circle()
                        .frame(width: 75, height: 75)
                        .foregroundColor(Color.clear)
                        .overlay(
                            Circle().stroke(Color.gray, lineWidth: 4.0))
                        .padding(.bottom, 40)
                Button(action: {self.audioRecorder.stopRecording()}) {
                    Image(systemName: "stop.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                        .clipped()
                        .foregroundColor(.red)
                        .padding(.bottom, 40)
                }
                }
            }
            }.navigationBarTitle("Voice Record")
        .navigationBarItems(trailing: EditButton())
        .cornerRadius(20)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(audioRecorder: AudioRecorder())
    }
}
