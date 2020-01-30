//
//  Beacons.swift
//  MuseumSensation
//
//  Created by iago salomon on 23/01/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

final class Beacons: NSObject, CLLocationManagerDelegate {
    
    //Inicializa locatio manager
    let locationManager = CLLocationManager()
    //ultima vez que o becon foi atualizado e ouve mudança na arte principal
    var lastMessure = [CLBeacon]()
    //last update in the secondary art
    var lastMessure2 = [CLBeacon]()
    
    var classMainArt: UIImageView!
    var classArtNameLabel: UILabel!
    var classSecondArtImage: UIImageView!
    
    init(mainArt: UIImageView, artNameLabel: UILabel, secondArtImage: UIImageView) {
        super.init()
        classMainArt = mainArt
        classArtNameLabel = artNameLabel
        classSecondArtImage = secondArtImage
        //set the locationManager delegate to self
        locationManager.delegate = self
        //ask for permission to use the beacons
        if CLLocationManager.authorizationStatus() != CLAuthorizationStatus.authorizedWhenInUse {
            locationManager.requestWhenInUseAuthorization()
        }
        //star the beacon serch
        //inicializa a procura pelos becons da marca estimote
        let nsuuid = NSUUID(uuidString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")
        if let clregion = nsuuid as UUID? {
            let region = CLBeaconRegion(proximityUUID: clregion, identifier: "Estimotes")
            locationManager.startRangingBeacons(in: region)
            
        }
    }
    
// Beacon tracking function
    func locationManager(_ manager: CLLocationManager,
      didRange beacons: [CLBeacon],
    satisfying beaconConstraint: CLBeaconIdentityConstraint){
        //get an array of beacon that are close
        var knownBeacons = beacons.filter { ($0.proximity == CLProximity.immediate) && ($0.accuracy > 0) }
        //order them by proxymity
        knownBeacons.sort { (beaconA, beaconB) -> Bool in
            beaconA.accuracy < beaconB.accuracy
        }
        //get an array for all beacon that are far
        var beaconOrder = beacons
        //order them by range
        beaconOrder.sort { (beaconA, beaconB) -> Bool in
            beaconA.accuracy < beaconB.accuracy
        }
        
        //see if you have a close beacon
        if knownBeacons.count > 0 {
            //do the desired functions for the closest beacon
            lastMessure = knownBeacons
            let closestBeacon = knownBeacons[0] as CLBeacon
            
            if let firstBeacon = closestBeacon.minor as? Int {
                if firstBeacon != ImageSingleton.shared.getCurrentImage() {
                    ImageSingleton.shared.setCurrentImage(beaconID: firstBeacon)
                    ImageSingleton.shared.setTitle(beaconID: firstBeacon)
                    ImageSingleton.shared.updateBackground(mainArt: classMainArt)
                    ImageSingleton.shared.updateTitle(label: classArtNameLabel)
                }
            }
        }
        
        //does the same function as before but for the seccondary art, as extra it dosent allow for the main and seccond art to be  the same
        if beaconOrder.count >= 2 && knownBeacons.count > 0 {
            if beaconOrder[1] != lastMessure[0] && beaconOrder != lastMessure2 {
                lastMessure2 = beaconOrder
                let secondClosest = beaconOrder[1] as CLBeacon
                if let secondClosestSafe = secondClosest.minor as? Int {
                    if secondClosestSafe != ImageSingleton.shared.getsecondClosestImage() && secondClosestSafe != ImageSingleton.shared.getCurrentImage() {
                        ImageSingleton.shared.setsecondClosestImage(beaconID: secondClosestSafe)
                        ImageSingleton.shared.updatesecondClosestImage(mainArt: classSecondArtImage)
                    }
                }
            }
        }
    }
}
