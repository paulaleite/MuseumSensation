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
        fadeNavigation(target: StartRecordingVC())
    }
    @IBAction func sendButton(_ sender: Any) {
        fadeNavigation(target: MainArtVC())
    }
    @IBAction func playButton(_ sender: Any) {
        AudioSingleton.shared.play()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        Manager.backgroundImage(image: mainArt)
        Manager.centerTitleTop(title: artNameLabel, view: view)
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
        setAcessibility()
        AudioSingleton.shared.setupPlayer()
        audioDuration()
        //updates the backgroud with the main art
        ImageSingleton.shared.updateBackground(mainArt: mainArt)
        ImageSingleton.shared.updateTitle(label: artNameLabel)
    }
    
    func setAcessibility() {
        //Art name
        artNameLabel.isAccessibilityElement = true
        artNameLabel.accessibilityTraits = UIAccessibilityTraits.none
        artNameLabel.accessibilityValue = "Nome da obra"
        artNameLabel.accessibilityLanguage = "pt-BR"
        
        //Main art
        mainArt.isAccessibilityElement = true
        mainArt.accessibilityTraits = UIAccessibilityTraits.image
        mainArt.accessibilityValue = "Foto da obra"
        mainArt.accessibilityLanguage = "pt-BR"
        
        //Play button
        playButtonOutlet.isAccessibilityElement = true
        playButtonOutlet.accessibilityTraits = UIAccessibilityTraits.button
        playButtonOutlet.accessibilityValue = "Escutar áudio gravado"
        playButtonOutlet.accessibilityLanguage = "pt-BR"
        
        //Send audio
        sendButtonOutlet.isAccessibilityElement = true
        sendButtonOutlet.accessibilityTraits = UIAccessibilityTraits.button
        sendButtonOutlet.accessibilityValue = "Enviar áudio gravado para a base de dados"
        sendButtonOutlet.accessibilityLanguage = "pt-BR"
        
        //Delete audio
        garbageButtonOutlet.isAccessibilityElement = true
        garbageButtonOutlet.accessibilityTraits = UIAccessibilityTraits.button
        garbageButtonOutlet.accessibilityValue = "Deletar áudio gravado"
        garbageButtonOutlet.accessibilityLanguage = "pt-BR"
        
        //Total time
        totalTime.isAccessibilityElement = true
        totalTime.accessibilityTraits = UIAccessibilityTraits.none
        totalTime.accessibilityValue = "Tempo total de áudio gravado"
        totalTime.accessibilityLanguage = "pt-BR"
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
    func audioIsPlaying() {
        
    }
     
}
