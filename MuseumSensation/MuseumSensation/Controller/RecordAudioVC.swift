//
//  RecordAudioVC.swift
//  MuseumSensation
//
//  Created by Fabrício Guilhermo on 09/09/19.
//  Copyright © 2019 Paula Leite. All rights reserved.
//

import UIKit

class RecordAudioVC: UIViewController {
    @IBOutlet weak var artNameLabel: UILabel!
    @IBOutlet weak var gradientLayerTop: UIView!
    @IBOutlet weak var gradientLayerBottom: UIView!
    @IBOutlet weak var mainArt: UIImageView!
    @IBOutlet weak var startRecordingImage: UIImageView!
    @IBOutlet weak var startRecordingButtonOutlet: UIButton!
    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var backButtonOutlet: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    
    var minutes: Int = 0
    var seconds: Int = 0
    var recording: Bool = false
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func startRecording(_ sender: Any) {
        switch recording {
        case true:
            recording = false
        case false:
            recording = true
        }
        switch recording {
        case true:
            startRecordingImage.image = UIImage(named: "stoprecording")
            // Audio
            AudioSingleton.shared.stopPlaying()
            if AudioSingleton.shared.haveFileName() {
                AudioSingleton.shared.deleteAudioFile(name: AudioSingleton.shared.getFileName())
            }
            let nome = DateFormatter()
            nome.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            let nomeString = nome.string(from: Date())
            AudioSingleton.shared.setFile(name: nomeString)
            AudioSingleton.shared.setupRecorder()
            AudioSingleton.shared.record()
            minutes = 0
            seconds = 0
            timer()
        case false:
            AudioSingleton.shared.stopRecord()
            AudioSingleton.shared.setupPlayer()
            fadeNavigation(target: ReviewAudioVC())
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Manager.backgroundImage(image: mainArt)
        Manager.centerTitleTop(title: artNameLabel, icon: backImage)
        Manager.gradientTopToBottom(viewToGradient: gradientLayerTop, topToBottom: true)
        Manager.gradientTopToBottom(viewToGradient: gradientLayerBottom, topToBottom: false)
        Manager.topViewGradiented(viewGradiented: gradientLayerTop, view: view)
        Manager.botViewGradiented(viewGradiented: gradientLayerBottom, view: view)
        Manager.centerIconBottom(icon: startRecordingImage, view: view)
        Manager.buttonOnView(button: startRecordingButtonOutlet, image: startRecordingImage)
        Manager.topLeftPosition(icon: backImage, title: artNameLabel)
        Manager.buttonOnView(button: backButtonOutlet, image: backImage)
        timeLabelPosition(timeLabel: timeLabel, icon: startRecordingImage)
        // Acessibility
        SetAccessibility.titleAccessibility(title: artNameLabel)
        SetAccessibility.mainArtAccessibility(mainArt: mainArt)
        SetAccessibility.backButton(backButton: backButtonOutlet)
        SetAccessibility.startRecording(startRecording: startRecordingButtonOutlet)
        //updates the backgroud with the main art
        ImageSingleton.shared.updateBackground(mainArt: mainArt)
        ImageSingleton.shared.updateTitle(label: artNameLabel)
    }
    
    /**
     *To position the time label*
     - Parameters:
     - timeLabel: The label that shows the time
     - icon: The bottom center icon
     - returns: Nothing
     */
    func timeLabelPosition(timeLabel: UILabel, icon: UIImageView) {
        timeLabel.center.y = icon.center.y
        timeLabel.center.x = timeLabel.frame.width/2 + Manager.distanceToBorders
    }
    /**
     *Start a timer*
     - returns: Nothing
     */
    func timer() {
        _ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.timeIncrement()
        }
    }
    /**
     *Increment the time label in the view*
     - returns: Nothing
     */
    @objc func timeIncrement() {
        seconds += 1
        if seconds == 60 {
            seconds =  0
            minutes += 1
        }
        var points: String = ""
        if seconds < 10 {
            points = ":0"
        } else {
            points = ":"
        }
        timeLabel.text = String(minutes) + points + String(seconds)
        UserDefaults.standard.set(String(minutes) + points + String(seconds), forKey: "recordTime")
    }
}
