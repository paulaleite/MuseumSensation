//
//  AudioPlayerVC.swift
//  MuseumSensation
//
//  Created by Paula Leite on 23/08/19.
//  Copyright © 2019 Paula Leite. All rights reserved.
//

import UIKit

class AudioPlayerVC: UIViewController {
    var isPlaying: Bool = true
    @IBOutlet weak var artNameLabel: UILabel!
    @IBOutlet weak var gradientLayerTop: UIView!
    @IBOutlet weak var gradientLayerBottom: UIView!
    @IBOutlet weak var mainArt: UIImageView!
    @IBOutlet weak var back: UIImageView!
    @IBOutlet weak var backButtonOutlet: UIButton!
    @IBOutlet weak var pause: UIImageView!
    @IBOutlet weak var nextOutlet: UIImageView!
    @IBOutlet weak var audioCounter: UILabel!
    @IBOutlet weak var speaker: UIImageView!
    @IBOutlet weak var progressBar: UIView!
    @IBOutlet weak var currentTime: UILabel!
    @IBOutlet weak var totalTime: UILabel!
    @IBOutlet weak var pauseButtonOutlet: UIButton!
    @IBAction func pauseButton(_ sender: Any) {
        switch isPlaying {
        case true:
            pause.image = UIImage.init(named: "play")
            AudioSingleton.shared.stopPlaying()
            isPlaying = false
        case false:
            pause.image = UIImage.init(named: "pause")
            AudioSingleton.shared.play()
            isPlaying = true
        }
    }
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        Manager.backgroundImage(image: mainArt, view: view)
        Manager.centerTitleTop(title: artNameLabel, view: view)
        Manager.gradientTopToBottom(viewToGradient: gradientLayerTop, topToBottom: true)
        Manager.gradientTopToBottom(viewToGradient: gradientLayerBottom, topToBottom: false)
        Manager.topViewGradiented(viewGradiented: gradientLayerTop, view: view)
        Manager.botViewGradiented(viewGradiented: gradientLayerBottom, view: view)
        Manager.topLeftPosition(icon: back, title: artNameLabel)
        Manager.buttonOnView(button: backButtonOutlet, image: back)
        Manager.centerIconBottom(icon: pause, view: view)
        nextButtonPosition(button: nextOutlet, center: pause)
        counterPosition(counter: audioCounter, center: pause)
        speakerPosition(speaker: speaker, counter: audioCounter)
        progressBarEdited(progressBar: progressBar, icon: pause, view: view)
        audioTime(currentTime: currentTime, totalTime: totalTime, progressBar: progressBar, icon: pause, view: view)
        Manager.buttonOnView(button: pauseButtonOutlet, image: pause)
        AudioSingleton.shared.setupPlayer()//deve ser trocado por funcao que retorna audio do servidor
    }
    /**
     *Postion the next button*
     - Parameters:
        - button: Button to position on the right side of the center icon
        - center: The central icon
     - returns: Nothing
     */
    func nextButtonPosition(button: UIImageView, center: UIImageView) {
        button.center.y = center.center.y
        button.center.x = center.center.x + center.frame.width/2 + button.frame.width/2 + Manager.distanceToBorders
    }
    /**
     *Postion the audio counter*
     - Parameters:
        - counter: Counter to position on the left side of the center icon
        - center: The central icon
     - returns: Nothing
     */
    func counterPosition(counter: UILabel, center: UIImageView) {
        counter.center.y = center.center.y
        counter.center.x = center.center.x - center.frame.width/2 - counter.frame.width/2 - Manager.distanceToBorders
    }
    /**
     *Postion the speaker*
     - Parameters:
        - speaker: The speaker to position in the right bottom of the counter
        - center: The central icon
     - returns: Nothing
     */
    func speakerPosition(speaker: UIImageView, counter: UILabel) {
        speaker.center.y = counter.center.y + counter.frame.height/2
        speaker.center.x = counter.center.x + counter.frame.width/2
    }
    /**
     *Edit and format the progress bar*
     - Parameters:
        - progressBar: The speaker to be edited
        - icon: The central icon
        - view: The main view
     - returns: Nothing
     */
    func progressBarEdited(progressBar: UIView, icon: UIImageView, view: UIView) {
        progressBar.frame.size.width = view.frame.width - Manager.distanceToBorders*2
        progressBar.center.x = view.center.x
        progressBar.center.y = view.frame.height - icon.frame.height - progressBar.frame.height/2 - Manager.distanceToBorders*2
        progressBar.layer.cornerRadius = 10
    }
    /**
     *Edit and position the audio label progress*
     - Parameters:
        - currentTime: The audio current time
        - totalTime: The audio total time
        - progressBar: The speaker to be edited
        - icon: The central icon
        - view: The main view
     - returns: Nothing
     */
    func audioTime(currentTime: UILabel, totalTime: UILabel, progressBar: UIView, icon: UIImageView, view: UIView) {
        currentTime.center.x = Manager.distanceToBorders + currentTime.frame.width/2
        currentTime.center.y = view.frame.height - icon.frame.height - progressBar.frame.height - Manager.distanceToBorders*2 - currentTime.frame.height/2
        totalTime.center.x = view.frame.width - Manager.distanceToBorders - totalTime.frame.width/2
        totalTime.center.y = view.frame.height - icon.frame.height - progressBar.frame.height - Manager.distanceToBorders*2 - currentTime.frame.height/2
    }
}
