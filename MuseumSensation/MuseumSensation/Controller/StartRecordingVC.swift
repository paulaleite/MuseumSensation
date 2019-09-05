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
    @IBOutlet weak var startRecordingButton: UIButton!
    @IBOutlet weak var back: UIImageView!
    @IBOutlet weak var backButtonOutlet: UIButton!
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func startRecordingButton(_ sender: Any) {
        fadeNavigation(target: RecordingVC())
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        Manager.backgroundImage(image: mainArt)
        Manager.centerTitleTop(title: artNameLabel, view: view)
        Manager.gradientTopToBottom(viewToGradient: gradientLayerTop, topToBottom: true)
        Manager.gradientTopToBottom(viewToGradient: gradientLayerBottom, topToBottom: false)
        Manager.topViewGradiented(viewGradiented: gradientLayerTop, view: view)
        Manager.botViewGradiented(viewGradiented: gradientLayerBottom, view: view)
        Manager.centerIconBottom(icon: startRecording, view: view)
        Manager.topLeftPosition(icon: back, title: artNameLabel)
        Manager.buttonOnView(button: backButtonOutlet, image: back)
        Manager.buttonOnView(button: startRecordingButton, image: startRecording)
        // Acessibility
        setAcessibility()
        //updates the backgroud with the main art
        ImageSingleton.shared.updateBackground(mainArt: mainArt)
        ImageSingleton.shared.updateTitle(label: artNameLabel)

    }
    
    func setAcessibility() {
        //Art name
        artNameLabel.isAccessibilityElement = true
        artNameLabel.accessibilityTraits = UIAccessibilityTraits.staticText
        artNameLabel.accessibilityValue = "Nome da obra"
        artNameLabel.accessibilityLanguage = "pt-BR"
        
        //Main art
        mainArt.isAccessibilityElement = true
        mainArt.accessibilityTraits = UIAccessibilityTraits.image
        mainArt.accessibilityValue = "Foto da obra"
        mainArt.accessibilityLanguage = "pt-BR"
        
        //Back button
        backButtonOutlet.isAccessibilityElement = true
        backButtonOutlet.accessibilityTraits = UIAccessibilityTraits.button
        backButtonOutlet.accessibilityValue = "Voltar para a tela anterior"
        backButtonOutlet.accessibilityLanguage = "pt-BR"
        backButtonOutlet.accessibilityHint = "É recomendado caso você queira ir para uma outra obra ou gravar algum áudio"
        
        // startRecordingButton
        startRecordingButton.isAccessibilityElement = true
        startRecordingButton.accessibilityTraits = UIAccessibilityTraits.button
        startRecordingButton.accessibilityValue = "Gravar um áudio"
        startRecordingButton.accessibilityLanguage = "pt-BR"
    }
}
