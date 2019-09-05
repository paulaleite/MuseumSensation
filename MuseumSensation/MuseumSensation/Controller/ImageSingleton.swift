//
//  ImageSingleton.swift
//  MuseumSensation
//
//  Created by Paula Leite on 04/09/19.
//  Copyright © 2019 Paula Leite. All rights reserved.
//

import Foundation
import UIKit

final class ImageSingleton: NSObject {
    
    static let shared = ImageSingleton()
    private var currentImage: Int?
    private var secondClosestImage: Int?
    private var artTitle: String?
    
    override init() {
        super.init()
    }
    
    /**
     *Set the image as the background*
     - Parameters:
        - mainArt: Name of the UIImage view that is in the view background
     - returns: Nothing
     */
    public func updateBackground(mainArt: UIImageView) {
        guard let currentImage = currentImage else {
            return
        }
        mainArt.imageFromServerURL(urlString: Manager.getImage(beacon: currentImage)) { (res, err) in
            if err == nil {
                guard let res = res else {
                    return
                }
                print(res)
            }
        }
    }
    
    /**
     *set the current image variable*
     - Parameters:
        - BeaconID: Beacon minor value
     - returns: Nothing
     */
    public func setCurrentImage(beaconID: Int) {
        currentImage = beaconID
        //variavel pra deixar a paula feliz
    }
    
    /**
     *return que current image minor value*
     - returns: int
     */
    public func getCurrentImage() -> Int {
        guard let curentImage = currentImage else {
            return 0
        }
        return curentImage
    }
    
    /**
     *set second image value in the view*
     - Parameters:
        - mainArt: Name of the UIImage view that is in the second colest image view
     - returns: Nothing
     */
    public func updatesecondClosestImage(mainArt: UIImageView) {
        guard let currentImage = currentImage else {
            return
        }
        mainArt.imageFromServerURL(urlString: Manager.getImage(beacon: currentImage)) { (res, err) in
            if err == nil {
                guard let res = res else {
                    return
                }
                print(res)
            }
        }
    }
    
    /**
     *Set the second closes image background*
     - Parameters:
        - mainArt: Name of the UIImage view that is in the view background
     - returns: Nothing
     */
    public func setsecondClosestImage(beaconID: Int) {
        secondClosestImage = beaconID
        //variavel pra deixar a paula feliz
    }
    
    /**
     *get the image as the background*
     - returns: int
     */
    public func getsecondClosestImage() -> Int {
        guard let curentImage = secondClosestImage else {
            return 0
        }
        return curentImage
    }
    
    /**
     *Place the title of the art in each of the screens*
     - returns: int
     */
    public func setTitle(beaconID: Int) {
        artTitle = InternObra.getNomeObra(obraID: beaconID).titulo
        print(artTitle)
    }
    
    public func updateTitle(label: UILabel) {
        label.text = artTitle
    }
}
