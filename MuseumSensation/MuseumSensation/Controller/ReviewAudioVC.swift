//
//  ReviewAudioVC.swift
//  MuseumSensation
//
//  Created by Paula Leite on 23/08/19.
//  Copyright © 2019 Paula Leite. All rights reserved.
//

import UIKit

class ReviewAudioVC: UIViewController {
    @IBOutlet weak var artNameLabel: UILabel!
    @IBOutlet weak var gradientLayerTop: UIView!
    @IBOutlet weak var mainArt: UIImageView!
    @IBOutlet weak var gradientLayerBottom: UIView!
    @IBOutlet weak var bigPlay: UIImageView!
    @IBOutlet weak var garbage: UIImageView!
    @IBOutlet weak var send: UIImageView!
    @IBOutlet weak var totalTime: UILabel!
    @IBOutlet weak var garbageButtonOutlet: UIButton!
    @IBOutlet weak var sendButtonOutlet: UIButton!
    @IBOutlet weak var playButtonOutlet: UIButton!
    @IBAction func garbageButton(_ sender: Any) {
        if AudioSingleton.shared.haveFileName() {
            AudioSingleton.shared.deleteAudioFile(name: AudioSingleton.shared.getFileName())
        }
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func sendButton(_ sender: Any) {
        AudioSingleton.shared.sendAudio()
        if AudioSingleton.shared.haveFileName() {
            AudioSingleton.shared.deleteAudioFile(name: AudioSingleton.shared.getFileName())
        }
        fadeNavigation(target: MainArtVC())
    }
    @IBAction func playButton(_ sender: Any) {
        AudioSingleton.shared.play()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        Manager.backgroundImage(image: mainArt)
        Manager.centerTitleTop(title: artNameLabel)
        Manager.gradientTopToBottom(viewToGradient: gradientLayerTop, topToBottom: true)
        Manager.gradientTopToBottom(viewToGradient: gradientLayerBottom, topToBottom: false)
        Manager.topViewGradiented(viewGradiented: gradientLayerTop, view: view)
        Manager.botViewGradiented(viewGradiented: gradientLayerBottom, view: view)
        Manager.centerIcon(iconImage: bigPlay)
        garbagePosition(garbage: garbage)
        sendPosition(send: send)
        totalTimePosition(totalTime: totalTime)
        Manager.buttonOnView(button: garbageButtonOutlet, image: garbage)
        Manager.buttonOnView(button: sendButtonOutlet, image: send)
        Manager.buttonOnView(button: playButtonOutlet, image: bigPlay)
        // Acessibility
        SetAccessibility.titleAccessibility(title: artNameLabel)
        SetAccessibility.mainArtAccessibility(mainArt: mainArt)
        SetAccessibility.toHearAudio(bigPlay: playButtonOutlet)
        SetAccessibility.sendButton(sendButton: sendButtonOutlet)
        SetAccessibility.garbageButton(garbageButton: garbageButtonOutlet)
        SetAccessibility.totalTime(totalTime: totalTime)
        //
        AudioSingleton.shared.setupPlayer()
        audioDuration()
        //updates the backgroud with the main art
        ImageSingleton.shared.updateBackground(mainArt: mainArt)
        ImageSingleton.shared.updateTitle(label: artNameLabel)
    }
    
    /**
     *Set the garbage icon on view*
     - Parameters:
         - garbage: The garbage icon to position
         - view: The main view
     - returns: Nothing
     */
    func garbagePosition(garbage: UIImageView) {
        garbage.center.x = Manager.screenSize.width*(1/3)
        garbage.center.y = Manager.screenSize.height - Manager.distanceToBorders - garbage.frame.height/2
    }
    
    /**
     *Set the send icon on view*
     - Parameters:
        - send: The send icon to position
        - view: The main view
     - returns: Nothing
     */
    func sendPosition(send: UIImageView) {
        send.center.x = Manager.screenSize.width*(2/3)
        send.center.y = Manager.screenSize.height - Manager.distanceToBorders - send.frame.height/2
    }
    
    /**
     *Set the total time label on view*
     - Parameters:
        - totalTime: The totalTime label to position
        - view: The main view
     - returns: Nothing
     */
    func totalTimePosition(totalTime: UILabel) {
        totalTime.center.x = Manager.screenSize.width/2
        totalTime.center.y = Manager.screenSize.height - Manager.distanceToBorders - send.frame.height - totalTime.frame.height/2
    }
    
    /**
     *Setup the audio duration*
     - returns: Nothing
     */
    func audioDuration() {
        totalTime.text = UserDefaults.standard.string(forKey: "recordTime")
    }
}
