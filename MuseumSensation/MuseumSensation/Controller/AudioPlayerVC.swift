//
//  AudioPlayerVC.swift
//  MuseumSensation
//
//  Created by Paula Leite on 23/08/19.
//  Copyright © 2019 Paula Leite. All rights reserved.
//

import UIKit

class AudioPlayerVC: UIViewController {
    @IBOutlet weak var artNameLabel: UILabel!
    @IBOutlet weak var gradientLayerTop: UIView!
    @IBOutlet weak var gradientLayerBottom: UIView!
    @IBOutlet weak var mainArt: UIImageView!
    @IBOutlet weak var back: UIImageView!
    @IBOutlet weak var backButtonOutlet: UIButton!
    @IBOutlet weak var pause: UIImageView!
    @IBOutlet weak var nextOutlet: UIImageView!
    @IBOutlet weak var nextButtonOutlet: UIButton!
    @IBOutlet weak var audioCounter: UILabel!
    @IBOutlet weak var speaker: UIImageView!
    @IBOutlet weak var progressBar: UIView!
    @IBOutlet weak var currentTime: UILabel!
    @IBOutlet weak var totalTime: UILabel!
    @IBOutlet weak var pauseButtonOutlet: UIButton!
    @IBOutlet var animatedBar: UIView!
    var isPlaying = false
    var currentAudio = 0
    var audioList: [AudioCodable] = []
    @IBAction func pauseButton(_ sender: Any) {
        SetAccessibility.playPauseButtonAccessibility(pauseButtonOutlet: pauseButtonOutlet, pause: pause)
        let layer = animatedBar.layer
        if isPlaying {
            pauseLayer(layer: layer)
        } else {
            resumeLayer(layer: layer)
        }
    }
    @IBAction func backButton(_ sender: Any) {
        StreamingSingleton.shared.stopPlaying()
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func nextAudioButton(_ sender: Any) {
        self.currentAudio += 1
        if currentAudio <  audioList.count {
            let audioList = InterAudio.getAudios(obraID: "\(ImageSingleton.shared.getCurrentImage())")
            guard let audioNow = audioList[currentAudio].nome else {
                return
            }
            StreamingSingleton.shared.setupPlayerStream(name: audioNow)
//            audioProgressBarAnimation(duration: StreamingSingleton.shared.getAudioDuration())
            StreamingSingleton.shared.play()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        Manager.backgroundImage(image: mainArt)
        Manager.centerTitleTop(title: artNameLabel)
        Manager.gradientTopToBottom(viewToGradient: gradientLayerTop, topToBottom: true)
        Manager.gradientTopToBottom(viewToGradient: gradientLayerBottom, topToBottom: false)
        Manager.topViewGradiented(viewGradiented: gradientLayerTop, view: view)
        Manager.botViewGradiented(viewGradiented: gradientLayerBottom, view: view)
        Manager.topLeftPosition(icon: back, title: artNameLabel)
        Manager.buttonOnView(button: backButtonOutlet, image: back)
        Manager.centerIconBottom(icon: pause, view: view)
        nextButtonPosition(button: nextOutlet, center: pause)
        nextButtonPosition2(button: nextButtonOutlet, center: pause)
        counterPosition(counter: audioCounter, center: pause)
        speakerPosition(speaker: speaker, counter: audioCounter)
        progressBarEdited(progressBar: progressBar, icon: pause, view: view)
        audioTime(currentTime: currentTime, totalTime: totalTime, progressBar: progressBar, icon: pause, view: view)
        Manager.buttonOnView(button: pauseButtonOutlet, image: pause)
        // Acessibility
        SetAccessibility.titleAccessibility(title: artNameLabel)
        SetAccessibility.mainArtAccessibility(mainArt: mainArt)
        SetAccessibility.backButton(backButton: backButtonOutlet)
        SetAccessibility.totalTime(totalTime: totalTime)
        SetAccessibility.currentTimeAccessibility(currentTime: currentTime)
        SetAccessibility.audioCounterAccessibility(audioCounter: audioCounter)
        SetAccessibility.nextButtonAccessibility(nextOutlet: nextOutlet)
        //
        audioList = InterAudio.getAudios(obraID: "\(ImageSingleton.shared.getCurrentImage())")
        guard let audioNow = audioList[currentAudio].nome else {
            return
        }
        StreamingSingleton.shared.setupPlayerStream(name: audioNow)
        StreamingSingleton.shared.play()
        
        ImageSingleton.shared.updateBackground(mainArt: mainArt)
        ImageSingleton.shared.updateTitle(label: artNameLabel)
        audioCounter.text = "\(audioList.count)"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        audioProgressBarAnimation(duration: StreamingSingleton.shared.getAudioDuration())
        isPlaying = true
        
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
     *Postion the next button*
     - Parameters:
     - button: Button to position on the right side of the center icon
     - center: The central icon
     - returns: Nothing
     */
    func nextButtonPosition2(button: UIButton, center: UIImageView) {
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
        progressBar.frame.size.width = Manager.screenSize.width - (Manager.distanceToBorders*2)
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
    
    /**
     *Edits the way the progress bar works*
     - Parameters:
        - duration: The duration of the audio
     - returns: Nothing
     */
    func audioProgressBarAnimation(duration: TimeInterval) {
        UIView.animate(withDuration: duration) {
            self.animatedBar.frame.size.width = self.progressBar.frame.width
        }
    }
    func pauseLayer(layer: CALayer) {
        let pausedTime: CFTimeInterval = layer.convertTime(CACurrentMediaTime(), from: nil)
        layer.speed = 0.0
        layer.timeOffset = pausedTime
        isPlaying = false
    }
    
    func resumeLayer(layer: CALayer) {
        let pausedTime: CFTimeInterval = layer.timeOffset
        layer.speed = 1.0
        layer.timeOffset = 0.0
        layer.beginTime = 0.0
        let timeSincePause: CFTimeInterval = layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        layer.beginTime = timeSincePause
        isPlaying = true
    }
}
