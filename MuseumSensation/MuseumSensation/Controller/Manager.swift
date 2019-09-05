//
//  Manager.swift
//  MuseumSensation
//
//  Created by Fabrício Guilhermo on 27/08/19.
//  Copyright © 2019 Paula Leite. All rights reserved.
//

import Foundation
import UIKit

struct Manager {
    static let screenSize: CGRect = UIScreen.main.bounds
    static let iphoneNotch: CGFloat = 30
    static let distanceToBorders: CGFloat = 28
    
    static let colorsName = [46811: "roxo",
                             33895: "verde",
                             18337: "azul"]
    
    static let colors = [46811: UIColor.purple,
                         33895: UIColor.green,
                         18337: UIColor.blue]
    
    static let art = [46811: "art-CafeTerraceAtNight",
                      33895: "art-StarryNight",
                      18337: "art-VanGoghSelfPortrait"] as [Int: String]
    
    static let artImages = ["art-CafeTerraceAtNight": "https://br-museum-sensation.herokuapp.com/audio/",
                            "art-StarryNight": "https://br-museum-sensation.herokuapp.com/audio/",
                            "art-VanGoghSelfPortrait": "https://br-museum-sensation.herokuapp.com/audio/"]
    
    /**
     *Center and scales bqckground image*
     - Parameters:
     - image: A background image to scale and center
     - view: The backgroundview
     - returns: Nothing
     */
    static func backgroundImage(image: UIImageView) {
        image.frame.size.width = screenSize.width
        image.frame.size.height = screenSize.height
        image.center.x = screenSize.width/2
        image.center.y = screenSize.height/2
    }
    
    /**
     *To position view in the top*
     - Parameters:
     - viewGradiented: The view to position
     - view: The main view
     - returns: Nothing
     */
    static func topViewGradiented(viewGradiented: UIView, view: UIView) {
        viewGradiented.center.y = viewGradiented.frame.height/2
        viewGradiented.frame.size.width = screenSize.width
    }
    
    /**
     *To position view in the bot*
     - Parameters:
     - viewGradiented: The view to position
     - view: The main view
     - returns: Nothing
     */
    static func botViewGradiented(viewGradiented: UIView, view: UIView) {
        viewGradiented.center.y = screenSize.height - viewGradiented.frame.height/2
        viewGradiented.frame.size.width = screenSize.width
    }
    
    /**
     *Turn some view gradient with an invisible bottom*
     - Parameters:
     - viewGradiented: Any view to turn gradient
     - topToBottom: If true, the gradient starts on top
     - returns: Nothing
     */
    static func gradientTopToBottom(viewToGradient: UIView, topToBottom: Bool) {
        let gradient = CAGradientLayer()
        if topToBottom == true {
            gradient.startPoint = CGPoint(x: 0.5, y: 1)
            gradient.endPoint = CGPoint(x: 0.5, y: 0.0)
        } else {
            gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
            gradient.endPoint = CGPoint(x: 0.5, y: 1)
        }
        let whiteColor = UIColor.white
        gradient.colors = [whiteColor.withAlphaComponent(0).cgColor, whiteColor.withAlphaComponent(1).cgColor]
        gradient.locations = [NSNumber(value: 0), NSNumber(value: 1), NSNumber(value: 1)]
        gradient.frame = viewToGradient.bounds
        viewToGradient.layer.mask = gradient
    }
    
    /** 
     *Set some icon in the bottom center*
     - Parameters:
     - icon: The icon to position
     - view: The main view
     - returns: Nothing
     */
    static func centerIconBottom(icon: UIImageView, view: UIView) {
        icon.center.x = screenSize.width/2 
        icon.center.y = screenSize.height - icon.frame.height/2 - distanceToBorders
    }
    
    /**
     *Set the title on the top center*
     - Parameters:
     - title: A ttitle to position on top
     - view: The main view
     - returns: Nothing
     */
    static func centerTitleTop(title: UILabel, view: UIView) {
        title.center.x = screenSize.width/2
        title.center.y =  title.frame.height/2 + distanceToBorders + iphoneNotch
        title.frame.size.width = screenSize.width
    }
    
    /**
     *Set the title on the top center*
     - Parameters:
     - icon: A ttitle to position on top
     - title: The main view
     - returns: Nothing
     */
    static func topLeftPosition(icon: UIImageView, title: UILabel) {
        icon.center.y = title.center.y
        icon.center.x = icon.frame.width/2 + distanceToBorders
    }
    
    /**
     *Center button on view*
     - Parameters:
     - button: Button to put on view
     - view: The base view
     - returns: Nothing
     */
    static func buttonOnView(button: UIButton, image: UIImageView) {
        button.center = image.center
    }
    
    /**
     *Center the play button on view*
     - Parameters:
     - iconImage: An image to center
     - view: The main view
     - returns: Nothing
     */
    static func centerIcon(iconImage: UIImageView) {
        iconImage.center.x = screenSize.width/2
        iconImage.center.y = screenSize.height/2
    }
    
    static func getImage(beacon: Int) -> String {
        let artName: String? = Manager.art[beacon]
        guard let artNameSafe = artName else {
            return ""
        }
        
        guard let url = Manager.artImages[artNameSafe] else {
            return ""
        }
        
        return url + artNameSafe + ".jpg"
        
    }
}
