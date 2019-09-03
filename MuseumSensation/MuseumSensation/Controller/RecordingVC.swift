//
//  RecordingVC.swift
//  MuseumSensation
//
//  Created by Paula Leite on 23/08/19.
//  Copyright © 2019 Paula Leite. All rights reserved.
//

import UIKit

class RecordingVC: UIViewController {
    @IBOutlet weak var artNameLabel: UILabel!
    @IBOutlet weak var gradientLayerTop: UIView!
    @IBOutlet weak var gradientLayerBottom: UIView!
    @IBOutlet weak var mainArt: UIImageView!
    @IBOutlet weak var stopRecording: UIImageView!
    @IBOutlet weak var stopRecordingButtonOutlet: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    
    var minutes: Int = 0
    var seconds: Int = 0
    @IBAction func stopRecordingButton(_ sender: Any) {
        AudioSingleton.shared.stopRecord()
        AudioSingleton.shared.setupPlayer()
        fadeNavigation(target: ReviewAudioVC())
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Autolayout
        Manager.backgroundImage(image: mainArt, view: view)
        Manager.centerTitleTop(title: artNameLabel, view: view)
        Manager.gradientTopToBottom(viewToGradient: gradientLayerTop, topToBottom: true)
        Manager.gradientTopToBottom(viewToGradient: gradientLayerBottom, topToBottom: false)
        Manager.topViewGradiented(viewGradiented: gradientLayerTop, view: view)
        Manager.botViewGradiented(viewGradiented: gradientLayerBottom, view: view)
        Manager.centerIconBottom(icon: stopRecording, view: view)
        Manager.buttonOnView(button: stopRecordingButtonOutlet, image: stopRecording)
        timeLabelPosition(timeLabel: timeLabel, icon: stopRecording)
        // Audio
        AudioSingleton.shared.setFile(name: "test")
        AudioSingleton.shared.setupRecorder()
        AudioSingleton.shared.record()
        minutes = 0
        seconds = 0
        timer()
        //updates the backgroud with the main art
        mainArt.backgroundColor = Manager.colors[UserDefaults.standard.integer(forKey: "closestArt")]

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
