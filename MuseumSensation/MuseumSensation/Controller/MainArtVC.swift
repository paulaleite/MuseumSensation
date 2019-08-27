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
    
/*
==================================================================
                       GLOBAL VARIABLES
==================================================================
*/
    let iphoneNotch: CGFloat = 30
    let distanceToBorders: CGFloat = 28
    let roundedBorder: CGFloat = 6
    let zeroPoint: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // image size equal main view size
        mainArt.frame = view.frame
        // set play button position
        centerIconBottom(icon: playButton)
        // frame edited
        editFrame(frame: secondArt)
        // microphone
        setIconBottomRight(icon: microphone)
        // art name
        centerTitleTop(title: artNameLabel)
        // icons background
        gradientTopToBottom(viewToGradient: gradientLayerTop, topToBottom: true)
        gradientTopToBottom(viewToGradient: gradientLayerBottom, topToBottom: false)
        
    }
    
    // function: set any icon on bottom right
    // parameters: the icon to be setted
    // return: without return, just position
    func setIconBottomRight(icon: UIImageView) {
        icon.center.x = view.frame.width -  microphone.frame.width/2 - distanceToBorders
        icon.center.y = playButton.center.y
    }
    
    // function: edit the frame and set it a position
    // parameters: the frame
    // return: without return, just position and borders
    func editFrame(frame: UIView) {
        frame.layer.cornerRadius = roundedBorder
        frame.center.x = zeroPoint + frame.frame.width/2 + distanceToBorders
    }
    
    /*
     ==================================================================
                           GLOBAL FUNCTIONS
     ==================================================================
     */
    
    // function: turn some view gradient with an invisible bottom
    // parameters: viewToGradient - any view to turn gradient
    //             topToBottom - an bool, if true, the gradient start on top
    // return: without return, just views change
    func gradientTopToBottom(viewToGradient: UIView, topToBottom: Bool){
        let gradient = CAGradientLayer()
        if topToBottom == true {
            gradient.startPoint = CGPoint(x: 0.5, y: 1)
            gradient.endPoint = CGPoint(x: 0.5, y: 0.0)
        } else {
            gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
            gradient.endPoint = CGPoint(x: 0.5, y: 1)
        }
        let whiteColor = UIColor.white
        gradient.colors = [whiteColor.withAlphaComponent(0.0).cgColor, whiteColor.withAlphaComponent(1.0).cgColor]
        gradient.locations = [NSNumber(value: 0.0),NSNumber(value: 1),NSNumber(value: 1.0)]
        gradient.frame = viewToGradient.bounds
        viewToGradient.layer.mask = gradient
        
    }
    
    // function: set some icon in the bottom center
    // parameters: the icon
    // return: without return, just position the icon
    func centerIconBottom(icon: UIImageView) {
        icon.center.x = view.center.x
        icon.center.y = view.frame.height - icon.frame.height/2 - distanceToBorders
    }
    
    // function: set the title on the top center
    // parameters: the title label
    // return: withou return, just position the title
    func centerTitleTop(title: UILabel) {
        title.center.x = view.center.x
        title.center.y =  title.frame.height/2 + distanceToBorders + iphoneNotch
    }
    
    
}
