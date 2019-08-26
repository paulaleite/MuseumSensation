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
    @IBOutlet weak var gradientLayer: UIView!
    
    let iphoneNotch: CGFloat = 30
    let distanceToBorders: CGFloat = 28
    let roundedBorder: CGFloat = 6
    let zeroPoint: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // image size equal main view size
        mainArt.frame = view.frame
        
        // set play button position
        playButton.center.x = view.center.x
        playButton.center.y = view.frame.height - playButton.frame.height/2 - distanceToBorders
        
        // frame edited
        secondArt.layer.cornerRadius = roundedBorder
        secondArt.center.x = zeroPoint + secondArt.frame.width/2 + distanceToBorders
        
        // microphone
        microphone.center.x = view.frame.width -  microphone.frame.width/2 - distanceToBorders
        microphone.center.y = playButton.center.y
        
        // art name
        artNameLabel.center.x = view.center.x
        artNameLabel.center.y =  artNameLabel.frame.height/2 + distanceToBorders + iphoneNotch
        
        let gradient = CAGradientLayer()
        gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.5, y: 0.6)
        let whiteColor = UIColor.white
        gradient.colors = [whiteColor.withAlphaComponent(0.0).cgColor, whiteColor.withAlphaComponent(1.0).cgColor, whiteColor.withAlphaComponent(1.0).cgColor]
        gradient.locations = [NSNumber(value: 0.0),NSNumber(value: 0.2),NSNumber(value: 1.0)]
        gradient.frame = gradientLayer.bounds
        gradientLayer.layer.mask = gradient
        
    }
}
