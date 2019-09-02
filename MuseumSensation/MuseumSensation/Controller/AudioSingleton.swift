//
//  AudioSingleton.swift
//  beacon-test
//
//  Created by iago salomon on 26/08/19.
//  Copyright © 2019 iago salomon. All rights reserved.
//

import Foundation
import  AVFoundation
import UIKit

final class AudioSingleton: NSObject {
    
    static let shared = AudioSingleton()
    private var isMicAccessGranted = false
    private var audioRecorder: AVAudioRecorder?
    private var audioPlayer: AVAudioPlayer?
    private var fileName: String?
    private let recordSettings = [AVFormatIDKey: kAudioFormatAppleLossless,
                                  AVEncoderAudioQualityKey: AVAudioQuality.max.rawValue,
                                  AVEncoderBitRateKey: 320000,
                                  AVNumberOfChannelsKey: 2 ,
                                  AVSampleRateKey: 44100.2] as [String: Any]
    
    override init() {
        super.init()
    }
    /**
     *Get the directiory where the audio is saved*
     - returns: URL
     */
    private func getDocumentDirectory() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
    /**
     *Setup a file name*
     - returns: Nothing
     */
    public func setFile(name: String) {
        self.fileName = name + ".m4a"
    }
    /**
     *Get a file name*
     - returns: file name
     */
    public func getFileName() -> String {
        guard let fileName = fileName else {
            return String() }
        return fileName
    }
    /**
     *Check if you have a file*
     - returns: If you have a file
     */
    public func haveFileName() -> Bool {
        if fileName != nil {
            return true
        }
        return false
    }
    /**
     *Delet a audio*
     - Parameters:
        - name: The name of tha audio that will be deleted
     - returns: Nothing
     */
    public func deleteAudioFile(name: String) {
        let audio = name + ".m4a"
        let documentsPath: URL = getDocumentDirectory()
        let audioPath = documentsPath.appendingPathComponent(audio)
        do {
            try FileManager.default.removeItem(at: audioPath)
        } catch {
            print(error)
        }
    }
    /**
     *Sets up the recorder*
     - returns: Nothing
     */
    public func setupRecorder() {
        guard let fileName = fileName else {
            return}
        let audioFileName = getDocumentDirectory().appendingPathComponent(fileName)
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(.playAndRecord, mode: .default, options: .defaultToSpeaker)
            try session.setActive(true)
            audioRecorder = try AVAudioRecorder(url: audioFileName, settings: recordSettings)
            guard let audioRecorder = audioRecorder else {
                return}
            audioRecorder.delegate = self
            audioRecorder.prepareToRecord()
        } catch {
            print(error)
        }
    }
    /**
     *Setup player*
     - returns: Nothing
     */
    public func setupPlayer() {
        guard let fileName = fileName else {
            return}
        let audioFileName = getDocumentDirectory().appendingPathComponent(fileName)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioFileName)
            guard let audioPlayer = audioPlayer else {
                return}
            audioPlayer.delegate = self
            audioPlayer.prepareToPlay()
            audioPlayer.volume = 1.0
            
        } catch {
            print(error)
        }
        
    }
    /**
     *Start Recording*
     - returns: Nothing
     */
    public func record() {
        guard let audioRecorder = audioRecorder else {
            return}
        audioRecorder.record(forDuration: 3600)
        
    }
    /**
     *Stop recording*
     - Parameters:
     - returns: Nothing
     */
    public func stopRecord() {
        guard let audioRecorder = audioRecorder else {
            return}
        audioRecorder.stop()
        
    }
    /**
     *Star Playing*
     - returns: Nothing
     */
    public func play() {
        guard let audioPlayer = audioPlayer else {
            return}
        audioPlayer.play()
    }
    /**
     *Stop Playing*
     - returns: Nothing
     */
    public func stopPlaying() {
        guard let audioPlayer = audioPlayer else {
            return}
        audioPlayer.stop()
    }
    /**
     *Discover the audio duration*
     - returns: a string that contain the duration in seconds
     */
    public func getAudioTime() -> String? {
        guard let audioPlayer = audioPlayer else {
            return nil }
        return audioPlayer.duration.description
    }
    /**
     *Check if the app has permission to use the mic and if not, it will ask the user for it*
     - returns: If you have permission
     */
    public func checkMicrophonePermission() -> Bool {
        switch AVAudioSession.sharedInstance().recordPermission {
        case .granted:
            isMicAccessGranted = true
        case .denied:
            isMicAccessGranted = false
        case .undetermined:
            AVAudioSession.sharedInstance().requestRecordPermission { (allowed) in
                if allowed {
                    self.isMicAccessGranted = true
                } else {
                    self.isMicAccessGranted = false
                }
            }
        default:
            break
        }
        return isMicAccessGranted
    }
    
    //Have to add into info.plist
    // The information property listprivacy -Microphone Usage Description and and description $(PRODUCT_NAME) needs to use microphone tho record audio
    
}

extension AudioSingleton: AVAudioPlayerDelegate {
    
}

extension AudioSingleton: AVAudioRecorderDelegate {
    
}
