//
//  AudioRecorderModel.swift
//  VoiceRecorderAppSwiftUI
//
//  Created by Page Kallop on 2/10/21.
//

import Foundation
import SwiftUI
import Combine
import AVFoundation

class AudioRecorder: NSObject, ObservableObject {
    
    override init() {
        
        super.init()
        fetchRecordings()
    }
    
    
    let objectWillChange = PassthroughSubject<AudioRecorder, Never>()
    
    var audioRecorder: AVAudioRecorder!
    
    var recordings = [RecordingDataModel]()
    
    //monitors if something is being recorded 
    var recording = false {
        didSet {
            objectWillChange.send(self)
        }
    }
 
    
    //creates recording session
    func startRecording() {
        let recordingSession = AVAudioSession.sharedInstance()
        //activates type of recording session
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
        } catch {
            print("Failed to set up recording session")
        }
        let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        let audioFileName = documentPath.appendingPathComponent("\(Date().toString(dateFormat: "dd-MM-YY_'at'_HH : mm:ss")).m4a")
        //defines recording settings
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 1200,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        //begins recording session 
        do {
            audioRecorder = try AVAudioRecorder(url: audioFileName, settings: settings)
            audioRecorder.record()
            
            recording = true
        } catch {
            print("Failed to start recoring")
        }
    }
    
    
    //stops recording session 
    func stopRecording()  {
        
        audioRecorder.stop()
        recording = false
        
        fetchRecordings()
    }
    
    func getCreationDate(for file: URL) -> Date {
        
        if let attributes = try? FileManager.default.attributesOfItem(atPath: file.path) as [FileAttributeKey: Any],
           let creationDate = attributes[FileAttributeKey.creationDate] as? Date {
            return creationDate
        } else {
            return Date()
            
        }
    }
    
    //fetches audio recordings
    func fetchRecordings() {
        //emptys array so recording aren't displayed multiple times
        recordings.removeAll()
        
        let fileManager = FileManager.default
        let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let directoryContents = try! fileManager.contentsOfDirectory(at: documentDirectory, includingPropertiesForKeys: nil)
        for audio in directoryContents {
            
            let recording = RecordingDataModel(fileURL: audio, createdAt: getCreationDate(for: audio))
            recordings.append(recording)
        }
        //sorts recordings
        recordings.sort(by: { $0.createdAt.compare($1.createdAt) == .orderedAscending})
        
        objectWillChange.send(self) 
    }
    
}


//formats date of m4a
extension Date {
    
    func toString( dateFormat format : String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
