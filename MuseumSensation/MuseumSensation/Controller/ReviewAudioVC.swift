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
        fadeNavigation(target: StartRecordingVC())
    }
    @IBAction func sendButton(_ sender: Any) {
        fadeNavigation(target: MainArtVC())
    }
    @IBAction func playButton(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        Manager.backgroundImage(image: mainArt, view: view)
        Manager.centerTitleTop(title: artNameLabel, view: view)
        Manager.gradientTopToBottom(viewToGradient: gradientLayerTop, topToBottom: true)
        Manager.gradientTopToBottom(viewToGradient: gradientLayerBottom, topToBottom: false)
        Manager.topViewGradiented(viewGradiented: gradientLayerTop, view: view)
        Manager.botViewGradiented(viewGradiented: gradientLayerBottom, view: view)
        Manager.centerIcon(iconImage: bigPlay, view: view)
        garbagePosition(garbage: garbage, view: view)
        sendPosition(send: send, view: view)
        totalTimePosition(totalTime: totalTime, view: view)
        Manager.buttonOnView(button: garbageButtonOutlet, image: garbage)
        Manager.buttonOnView(button: sendButtonOutlet, image: send)
        Manager.buttonOnView(button: playButtonOutlet, image: bigPlay)
    }
    /**
     *Set the garbage icon on view*
     - Parameters:
         - garbage: The garbage icon to position
         - view: The main view
     - returns: Nothing
     */
    func garbagePosition(garbage: UIImageView, view: UIView) {
        garbage.center.x = view.frame.width*(1/3)
        garbage.center.y = view.frame.height - Manager.distanceToBorders - garbage.frame.height/2
    }
    /**
     *Set the send icon on view*
     - Parameters:
        - send: The send icon to position
        - view: The main view
     - returns: Nothing
     */
    func sendPosition(send: UIImageView, view: UIView) {
        send.center.x = view.frame.width*(2/3)
        send.center.y = view.frame.height - Manager.distanceToBorders - send.frame.height/2
    }
    /**
     *Set the total time label on view*
     - Parameters:
        - totalTime: The totalTime label to position
        - view: The main view
     - returns: Nothing
     */
    func totalTimePosition(totalTime: UILabel, view: UIView) {
        totalTime.center.x = view.center.x
        totalTime.center.y = view.frame.height - Manager.distanceToBorders - send.frame.height - totalTime.frame.height/2
    }
}
