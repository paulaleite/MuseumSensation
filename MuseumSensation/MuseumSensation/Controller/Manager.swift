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
    // function: center and scales bqckground image
    // parameters: the background image and the main view
    // return: without return, just center and scales image
    static func backgroundImage(image: UIImageView, view: UIView) {
        image.frame = view.frame
        image.center = view.center
    }
    // function: position view in the top
    // parameters: the view to position and the main view
    // return: without return, just position gradiented view
    static func topViewGradiented(viewGradiented: UIView, view: UIView) {
        viewGradiented.center.y = viewGradiented.frame.height/2
        viewGradiented.frame.size.width = view.frame.width
    }
    // function: position view in the bot
    // parameters: the view to position and the main view
    // return: without return, just position gradiented view
    static func botViewGradiented(viewGradiented: UIView, view: UIView) {
        viewGradiented.center.y = view.frame.height - viewGradiented.frame.height/2
        viewGradiented.frame.size.width = view.frame.width
    }
    // function: turn some view gradient with an invisible bottom
    // parameters: viewToGradient - any view to turn gradient
    //             topToBottom - an bool, if true, the gradient start on top
    // return: without return, just views change
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
    // function: set some icon in the bottom center
    // parameters: the icon
    // return: without return, just position the icon
    static func centerIconBottom(icon: UIImageView, view: UIView) {
        icon.center.x = view.center.x
        icon.center.y = view.frame.height - icon.frame.height/2 - distanceToBorders
    }
    // function: set some icon in the bottom center
    // parameters: the icon
    // return: without return, just position the icon
    static func centerIconBottom(icon: UIButton, view: UIView) {
        icon.center.x = view.center.x
        icon.center.y = view.frame.height - icon.frame.height/2 - distanceToBorders
    }

    // function: set the title on the top center
    // parameters: the title label
    // return: withou return, just position the title
    static func centerTitleTop(title: UILabel, view: UIView) {
        title.center.x = view.center.x
        title.center.y =  title.frame.height/2 + distanceToBorders + iphoneNotch
    }
}
