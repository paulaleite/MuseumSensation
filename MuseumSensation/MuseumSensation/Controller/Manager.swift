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
    static let iphoneNotch: CGFloat = 30
    static let distanceToBorders: CGFloat = 28
    /**
     *Center and scales bqckground image*
     - Parameters:
        - image: A background image to scale and center
        - view: The backgroundview
     - returns: Nothing
     */
    static func backgroundImage(image: UIImageView, view: UIView) {
        image.frame = view.frame
        image.center = view.center
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
        viewGradiented.frame.size.width = view.frame.width
    }
    /**
     *To position view in the bot*
     - Parameters:
        - viewGradiented: The view to position
        - view: The main view
     - returns: Nothing
     */
    static func botViewGradiented(viewGradiented: UIView, view: UIView) {
        viewGradiented.center.y = view.frame.height - viewGradiented.frame.height/2
        viewGradiented.frame.size.width = view.frame.width
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
        gradient.colors = [whiteColor.withAlphaComponent(0.0).cgColor, whiteColor.withAlphaComponent(1.0).cgColor]
        gradient.locations = [NSNumber(value: 0.0), NSNumber(value: 1), NSNumber(value: 1.0)]
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
        icon.center.x = view.center.x
        icon.center.y = view.frame.height - icon.frame.height/2 - distanceToBorders
    }
    /**
     *Set some icon in the bottom center*
     - Parameters:
        - icon: The icon to position
        - view: The main view
     - returns: Nothing
     */
    static func centerIconBottom(icon: UIButton, view: UIView) {
        icon.center.x = view.center.x
        icon.center.y = view.frame.height - icon.frame.height/2 - distanceToBorders
    }
    /**
     *Set the title on the top center*
     - Parameters:
        - title: A ttitle to position on top
        - view: The main view
     - returns: Nothing
     */
    static func centerTitleTop(title: UILabel, view: UIView) {
        title.center.x = view.center.x
        title.center.y =  title.frame.height/2 + distanceToBorders + iphoneNotch
    }
}
