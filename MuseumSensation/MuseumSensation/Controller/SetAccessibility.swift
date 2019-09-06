//
//  SetAccessibility.swift
//  MuseumSensation
//
//  Created by Paula Leite on 06/09/19.
//  Copyright © 2019 Paula Leite. All rights reserved.
//

import Foundation
import UIKit
 
struct SetAccessibility {
    static func titleAccessibility(title: UILabel) {
        title.isAccessibilityElement = true
        title.accessibilityTraits = UIAccessibilityTraits.staticText
        title.accessibilityValue = "Nome da obra"
        title.accessibilityLanguage = "pt-BR"
    }
    
    static func mainArtAccessibility(mainArt: UIImageView) {
        mainArt.isAccessibilityElement = true
        mainArt.accessibilityTraits = UIAccessibilityTraits.image
        mainArt.accessibilityValue = "Foto da obra"
        mainArt.accessibilityLanguage = "pt-BR"
    }
    
    static func secondArtAccessibility(secondArt: UIImageView) {
        secondArt.isAccessibilityElement = true
        secondArt.accessibilityTraits = UIAccessibilityTraits.image
        secondArt.accessibilityValue = "Foto de uma outra obra mais próxima de você"
        secondArt.accessibilityHint = "Se você tiver interesse de se direcionar para uma próxima outra obra"
        secondArt.accessibilityLanguage = "pt-BR"
    }
    
    static func playButtonAccessibility(playButton: UIButton) {
        playButton.isAccessibilityElement = true
        playButton.accessibilityTraits = UIAccessibilityTraits.button
        playButton.accessibilityValue = "Escutar um áudio"
        playButton.accessibilityLanguage = "pt-BR"
    }
    
    static func startRecordingAccessibility(microphone: UIButton) {
        microphone.isAccessibilityElement = true
        microphone.accessibilityTraits = UIAccessibilityTraits.button
        microphone.accessibilityValue = "Gravar um áudio"
        microphone.accessibilityLanguage = "pt-BR"
    }
    
    static func toHearAudio(bigPlay: UIButton) {
        bigPlay.isAccessibilityElement = true
        bigPlay.accessibilityTraits = UIAccessibilityTraits.button
        bigPlay.accessibilityValue = "Escutar áudio gravado"
        bigPlay.accessibilityLanguage = "pt-BR"
    }
    
    static func sendButton(sendButton: UIButton) {
        sendButton.isAccessibilityElement = true
        sendButton.accessibilityTraits = UIAccessibilityTraits.button
        sendButton.accessibilityValue = "Enviar áudio gravado para a base de dados"
        sendButton.accessibilityLanguage = "pt-BR"
    }
    
    static func garbageButton(garbageButton: UIButton) {
        garbageButton.isAccessibilityElement = true
        garbageButton.accessibilityTraits = UIAccessibilityTraits.button
        garbageButton.accessibilityValue = "Deletar áudio gravado"
        garbageButton.accessibilityLanguage = "pt-BR"
    }
    
    static func totalTime(totalTime: UILabel) {
        totalTime.isAccessibilityElement = true
        totalTime.accessibilityTraits = UIAccessibilityTraits.none
        totalTime.accessibilityValue = "Tempo total de áudio gravado"
        totalTime.accessibilityLanguage = "pt-BR"
    }
}
