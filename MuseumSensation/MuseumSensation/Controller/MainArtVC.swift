//
//  MainArtVC.swift
//  MuseumSensation
//
//  Created by Paula Leite on 23/08/19.
//  Copyright © 2019 Paula Leite. All rights reserved.
//

import UIKit

class MainArtVC: UIViewController {
    @IBOutlet weak var mainArt: UIImageView!
    @IBOutlet weak var playButton: UIImageView!
    @IBOutlet weak var secondArt: UIView!
    @IBOutlet weak var microphone: UIImageView!
    @IBOutlet weak var artNameLabel: UILabel!
    @IBOutlet weak var gradientLayerTop: UIView!
    @IBOutlet weak var gradientLayerBottom: UIView!
    @IBOutlet weak var secondArtImage: UIImageView!
    @IBOutlet weak var goToAudioPlayerVC: UIButton!
    @IBOutlet weak var goToStartRecordingVC: UIButton!
    @IBAction func goToAudioPlayerVCButton(_ sender: Any) {
        fadeNavigation(target: AudioPlayerVC())
    }
    @IBAction func goToStartRecordingVCButton(_ sender: Any) {
        fadeNavigation(target: StartRecordingVC())
    }
    let roundedBorder: CGFloat = 6
    override func viewDidLoad() {
        super.viewDidLoad()
        Manager.backgroundImage(image: mainArt, view: view)
        Manager.centerIconBottom(icon: playButton, view: view)
        editFrame(frame: secondArt)
        Manager.backgroundImage(image: secondArtImage, view: secondArt)
        setIconBottomRight(icon: microphone)
        Manager.centerTitleTop(title: artNameLabel, view: view)
        Manager.gradientTopToBottom(viewToGradient: gradientLayerTop, topToBottom: true)
        Manager.gradientTopToBottom(viewToGradient: gradientLayerBottom, topToBottom: false)
        Manager.topViewGradiented(viewGradiented: gradientLayerTop, view: view)
        Manager.botViewGradiented(viewGradiented: gradientLayerBottom, view: view)
        Manager.buttonOnView(button: goToAudioPlayerVC, image: playButton)
        Manager.buttonOnView(button: goToStartRecordingVC, image: microphone)
        setIconBottomRight(icon: goToStartRecordingVC)
    }
    /**
     *Set any icon on bottom right*
     - Parameters:
        - icon: The icon to be setted
     - returns: Nothing
     */
    func setIconBottomRight(icon: UIImageView) {
        icon.center.x = view.frame.width -  microphone.frame.width/2 - Manager.distanceToBorders
        icon.center.y = playButton.center.y
    }
    /**
     *Set any icon on bottom right*
     - Parameters:
        - icon: The icon to be setted
        - returns: Nothing
     */
    func setIconBottomRight(icon: UIButton) {
        icon.center.x = view.frame.width -  microphone.frame.width/2 - Manager.distanceToBorders
        icon.center.y = playButton.center.y
    }
    /**
     *Edit the frame and set it a position*
     - Parameters:
        - frame: The frame
     - returns: Nothing
     */
    func editFrame(frame: UIView) {
        frame.layer.cornerRadius = roundedBorder
        frame.center.x = frame.frame.width/2 + Manager.distanceToBorders
    }
}
