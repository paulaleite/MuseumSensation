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

final class StreamingSingleton: NSObject {
    
    static let shared = StreamingSingleton()
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
     *Get the directiory where the audio is saved*
     - returns: URL
     */
    private func getDocumentDirectory() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
    
    /**
     *Delet a audio*
     - Parameters:
     - name: The name of tha audio that will be deleted
     - returns: Nothing
     */
    public func deleteAudioFile() {
        if haveFileName() {
        guard let name = self.fileName else {
                return
            }
        let audio = name
        let documentsPath: URL = getDocumentDirectory()
        let audioPath = documentsPath.appendingPathComponent(audio)
        do {
            try FileManager.default.removeItem(at: audioPath)
        } catch {
            print(error)
        }
        }
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
    
    /**
     *return the current audio duration*
     - returns: TimeInterval
     */
    public func getAudioDuration() -> TimeInterval {
        
        guard let audioPlayer = audioPlayer else {
            return 0
        }
        return audioPlayer.duration
    }
    
    public func makeURL(name: String) -> URL {
        if let url = URL(string: "https://br-museum-sensation.herokuapp.com/audioStream/\(name)") {
            return url
        } else {
            return URL.init(fileURLWithPath: "https://br-museum-sensation.herokuapp.com/audioStream/music2.m4a")
        }
        
    }
    
    /**
     *Setup player*
     - returns: Nothing
     */
    public func setupPlayerStream(name: String) {
        //delete the last audiofile saved to memorygit add .
        deleteAudioFile()
        let audioUrl = makeURL(name: name)
        
        guard let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return
        }
        // lets create your destination file url
        let destinationUrl = documentsDirectoryURL.appendingPathComponent(audioUrl.lastPathComponent)
        print(destinationUrl)
        
        // to check if it exists before downloading it
        if FileManager.default.fileExists(atPath: destinationUrl.path) {
            print("The file already exists at path")
            do {
                self.audioPlayer = try AVAudioPlayer(contentsOf: destinationUrl)
                guard let audioPlayer = self.audioPlayer else {
                    return }
                self.fileName = name
                audioPlayer.delegate = self
                audioPlayer.prepareToPlay()
                audioPlayer.volume = 1.0
                audioPlayer.play()
                
            } catch {
                print(error)
            }
            // if the file doesn't exist
        } else {
            
            // you can use NSURLSession.sharedSession to download the data asynchronously
            URLSession.shared.downloadTask(with: audioUrl, completionHandler: { (location, _, error) -> Void in
                guard let location = location, error == nil else {
                    return }
                do {
                    // after downloading your file you need to move it to your destination url
                    try FileManager.default.moveItem(at: location, to: destinationUrl)
                    print("File moved to documents folder")
                    do {
                        self.audioPlayer = try AVAudioPlayer(contentsOf: destinationUrl)
                        guard let audioPlayer = self.audioPlayer else {
                            return }
                        self.fileName = name
                        audioPlayer.delegate = self
                        audioPlayer.prepareToPlay()
                        audioPlayer.volume = 1.0
                        audioPlayer.play()
                    } catch {
                        print(error)
                    }
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
               
            }).resume()
        }
    }
    }

extension StreamingSingleton: AVAudioPlayerDelegate {
    
}

extension StreamingSingleton: AVAudioRecorderDelegate {
    
}
