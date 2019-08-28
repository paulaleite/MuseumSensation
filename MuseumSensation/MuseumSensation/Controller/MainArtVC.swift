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
    let roundedBorder: CGFloat = 6
    override func viewDidLoad() {
        super.viewDidLoad()
        // center and scales backgroun image
        Manager.backgroundImage(image: mainArt, view: view)
        // set play button position
        Manager.centerIconBottom(icon: playButton, view: view)
        // frame edited
        editFrame(frame: secondArt)
        Manager.backgroundImage(image: secondArtImage, view: secondArt)
        // microphone
        setIconBottomRight(icon: microphone)
        // art name
        Manager.centerTitleTop(title: artNameLabel, view: view)
        // icons background
        Manager.gradientTopToBottom(viewToGradient: gradientLayerTop, topToBottom: true)
        Manager.gradientTopToBottom(viewToGradient: gradientLayerBottom, topToBottom: false)
        // gradiented
        Manager.topViewGradiented(viewGradiented: gradientLayerTop, view: view)
        Manager.botViewGradiented(viewGradiented: gradientLayerBottom, view: view)

    }
    // function: set any icon on bottom right
    // parameters: the icon to be setted
    // return: without return, just position
    func setIconBottomRight(icon: UIImageView) {
        icon.center.x = view.frame.width -  microphone.frame.width/2 - Manager.distanceToBorders
        icon.center.y = playButton.center.y
    }
    // function: edit the frame and set it a position
    // parameters: the frame
    // return: without return, just position and borders
    func editFrame(frame: UIView) {
        frame.layer.cornerRadius = roundedBorder
        frame.center.x = frame.frame.width/2 + Manager.distanceToBorders
    }
}
