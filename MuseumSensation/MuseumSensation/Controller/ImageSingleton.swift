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
    
    override init() {
        super.init()
    }
    
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
    
    public func setCurrentImage(beaconID: Int) {
        currentImage = beaconID
        //variavel pra deixar a paula feliz
    }
    
    public func getCurrentImage() -> Int {
        guard let curentImage = currentImage else {
            return 0
        }
        return curentImage
    }
}
