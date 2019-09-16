//
//  MainArtVC.swift
//  MuseumSensation
//
//  Created by Paula Leite on 23/08/19.
//  Copyright © 2019 Paula Leite. All rights reserved.
//

import UIKit
import CoreLocation

class MainArtVC: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var mainArt: UIImageView!
    weak var mainArtCheck: UIImageView!
    @IBOutlet weak var playButton: UIImageView!
    @IBOutlet weak var secondArt: UIView!
    @IBOutlet weak var microphone: UIImageView!
    @IBOutlet weak var artNameLabel: UILabel!
    @IBOutlet weak var gradientLayerTop: UIView!
    @IBOutlet weak var gradientLayerBottom: UIView!
    @IBOutlet weak var secondArtImage: UIImageView!
    @IBOutlet weak var goToAudioPlayerVC: UIButton!
    @IBOutlet weak var goToStartRecordingVC: UIButton!
    var firstTime = true
    //Inicializa locatio manager
    let locationManager = CLLocationManager()
    //ultima vez que o becon foi atualizado e ouve mudança na arte principal
    var lastMessure = [CLBeacon]()
    //last update in the secondary art
    var lastMessure2 = [CLBeacon]()
    @IBAction func goToAudioPlayerVCButton(_ sender: Any) {
        fadeNavigation(target: AudioPlayerVC())
    }
    @IBAction func goToStartRecordingVCButton(_ sender: Any) {
        fadeNavigation(target: RecordAudioVC())
    }
    let roundedBorder: CGFloat = 6
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.set(0, forKey: "closestArt")
        Manager.backgroundImage(image: mainArt)
        Manager.centerIconBottom(icon: playButton, view: view)
        editFrame(frame: secondArt)
        setIconBottomRight(icon: microphone)
        Manager.centerTitleTop(title: artNameLabel)
        Manager.gradientTopToBottom(viewToGradient: gradientLayerTop, topToBottom: true)
        Manager.gradientTopToBottom(viewToGradient: gradientLayerBottom, topToBottom: false)
        Manager.topViewGradiented(viewGradiented: gradientLayerTop, view: view)
        Manager.botViewGradiented(viewGradiented: gradientLayerBottom, view: view)
        Manager.buttonOnView(button: goToAudioPlayerVC, image: playButton)
        Manager.buttonOnView(button: goToStartRecordingVC, image: microphone)
        setIconBottomRight(icon: goToStartRecordingVC)
        // Acessibility
        SetAccessibility.mainArtAccessibility(mainArt: mainArt)
        SetAccessibility.playButtonAccessibility(playButton: goToAudioPlayerVC)
        SetAccessibility.secondArtAccessibility(secondArt: secondArtImage)
        SetAccessibility.startRecordingAccessibility(microphone: goToStartRecordingVC)
        SetAccessibility.titleAccessibility(title: artNameLabel)
        
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
    
    /**
     *Set any icon on bottom right*
     - Parameters:
        - icon: The icon to be setted
     - returns: Nothing
     */
    func setIconBottomRight(icon: UIImageView) {
        icon.center.x = Manager.screenSize.width - microphone.frame.width/2 - Manager.distanceToBorders
        icon.center.y = playButton.center.y
    }
    
    /**
     *Set any icon on bottom right*
     - Parameters:
        - icon: The icon to be setted
     - returns: Nothing
     */
    func setIconBottomRight(icon: UIButton) {
        icon.center.x = Manager.screenSize.width - microphone.frame.width/2 - Manager.distanceToBorders
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
        frame.center.y = Manager.screenSize.height - frame.frame.height/2 - Manager.distanceToBorders
    }
    
    // Beacon tracking function
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
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
                    ImageSingleton.shared.updateBackground(mainArt: mainArt)
                    ImageSingleton.shared.updateTitle(label: artNameLabel)
                    
                }
            }
        }
        
        //does the same function as before but for the seccondary art, as extra it dosent allow for the main and seccond art to be  the same
        if beaconOrder.count >= 2 && knownBeacons.count > 0 {
            if beaconOrder[1] != lastMessure[0] && beaconOrder != lastMessure2 {
                lastMessure2 = beaconOrder
                let secondClosest = beaconOrder[1] as CLBeacon
                if let secondClosestSafe = secondClosest.minor as? Int {
                    if secondClosestSafe != ImageSingleton.shared.getsecondClosestImage() {
                        ImageSingleton.shared.setsecondClosestImage(beaconID: secondClosestSafe)
                        ImageSingleton.shared.updatesecondClosestImage(mainArt: secondArtImage)
                    }
                }
            }
        }
    }
    
}
