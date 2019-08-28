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
    @IBAction func stopRecordingButton(_ sender: Any) {
        fadeNavigation(target: ReviewAudioVC())
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        Manager.backgroundImage(image: mainArt, view: view)
        Manager.centerTitleTop(title: artNameLabel, view: view)
        Manager.gradientTopToBottom(viewToGradient: gradientLayerTop, topToBottom: true)
        Manager.gradientTopToBottom(viewToGradient: gradientLayerBottom, topToBottom: false)
        Manager.topViewGradiented(viewGradiented: gradientLayerTop, view: view)
        Manager.botViewGradiented(viewGradiented: gradientLayerBottom, view: view)
        Manager.centerIconBottom(icon: stopRecording, view: view)
        Manager.buttonOnView(button: stopRecordingButtonOutlet, image: stopRecording)
        timeLabelPosition(timeLabel: timeLabel, icon: stopRecording)
    }
    func timeLabelPosition(timeLabel: UILabel, icon: UIImageView) {
        timeLabel.center.y = icon.center.y
        timeLabel.center.x = timeLabel.frame.width/2 + Manager.distanceToBorders
    }
}
