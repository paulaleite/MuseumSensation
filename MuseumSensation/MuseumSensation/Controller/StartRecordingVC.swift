//
//  StartRecordingVC.swift
//  MuseumSensation
//
//  Created by Paula Leite on 23/08/19.
//  Copyright © 2019 Paula Leite. All rights reserved.
//

import UIKit

class StartRecordingVC: UIViewController {
    @IBOutlet weak var artNameLabel: UILabel!
    @IBOutlet weak var gradientLayerTop: UIView!
    @IBOutlet weak var gradientLayerBottom: UIView!
    @IBOutlet weak var mainArt: UIImageView!
    @IBOutlet weak var startRecording: UIImageView!
    @IBOutlet weak var backButtonOutlet: UIButton!
    @IBAction func backButton(_ sender: Any) {
        fadeNavigation(target: RecordingVC())
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // center and scales backgroun image
        Manager.backgroundImage(image: mainArt, view: view)
        // art name
        Manager.centerTitleTop(title: artNameLabel, view: view)
        // icons background
        Manager.gradientTopToBottom(viewToGradient: gradientLayerTop, topToBottom: true)
        Manager.gradientTopToBottom(viewToGradient: gradientLayerBottom, topToBottom: false)
        // gradiented
        Manager.topViewGradiented(viewGradiented: gradientLayerTop, view: view)
        Manager.botViewGradiented(viewGradiented: gradientLayerBottom, view: view)
        Manager.centerIconBottom(icon: startRecording, view: view)
        // button bottom
        Manager.centerIconBottom(icon: backButtonOutlet, view: view)
    }
}

extension UIViewController {
    func fadeNavigation(target: UIViewController) {
        let goVC = target
        goVC.modalPresentationStyle = .custom
        goVC.modalTransitionStyle = .crossDissolve
        self.present(goVC, animated: true, completion: nil)
    }
}
