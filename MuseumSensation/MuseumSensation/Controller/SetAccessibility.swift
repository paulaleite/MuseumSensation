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
    static var isPlaying: Bool = true
    
    /**
     *Set accessibility to the art title*
     - Parameters:
        - title: The art title
     - returns: Nothing
     */
    static func titleAccessibility(title: UILabel) {
        title.isAccessibilityElement = true
        title.accessibilityTraits = UIAccessibilityTraits.staticText
        title.accessibilityValue = "Nome da obra"
        title.accessibilityLanguage = "pt-BR"
    }
    
    /**
     *Set accessibility to the background image*
     - Parameters:
        - mainArt: The background image
     - returns: Nothing
     */
    static func mainArtAccessibility(mainArt: UIImageView) {
        mainArt.isAccessibilityElement = true
        mainArt.accessibilityTraits = UIAccessibilityTraits.image
        mainArt.accessibilityValue = "Foto da obra"
        mainArt.accessibilityLanguage = "pt-BR"
    }
    
    /**
     *Set accessibility to the second art*
     - Parameters:
        - secondArt: The second art
     - returns: Nothing
     */
    static func secondArtAccessibility(secondArt: UIImageView) {
        secondArt.isAccessibilityElement = true
        secondArt.accessibilityTraits = UIAccessibilityTraits.image
        secondArt.accessibilityValue = "Foto de uma outra obra mais próxima de você"
        secondArt.accessibilityHint = "Se você tiver interesse de se direcionar para uma próxima outra obra"
        secondArt.accessibilityLanguage = "pt-BR"
    }
    
    /**
     *Set accessibility to listen to an audio*
     - Parameters:
        - playButton: The play button
     - returns: Nothing
     */
    static func playButtonAccessibility(playButton: UIButton) {
        playButton.isAccessibilityElement = true
        playButton.accessibilityTraits = UIAccessibilityTraits.button
        playButton.accessibilityValue = "Escutar um áudio"
        playButton.accessibilityLanguage = "pt-BR"
    }
    
    /**
     *Set accessibility to record an audio*
     - Parameters:
        - microphone: The microphone button
     - returns: Nothing
     */
    static func startRecordingAccessibility(microphone: UIButton) {
        microphone.isAccessibilityElement = true
        microphone.accessibilityTraits = UIAccessibilityTraits.button
        microphone.accessibilityValue = "Gravar um áudio"
        microphone.accessibilityLanguage = "pt-BR"
    }
    
    /**
     *Set accessibility to listen to an audio*
     - Parameters:
        - bigPlay: The play button
     - returns: Nothing
     */
    static func toHearAudio(bigPlay: UIButton) {
        bigPlay.isAccessibilityElement = true
        bigPlay.accessibilityTraits = UIAccessibilityTraits.button
        bigPlay.accessibilityValue = "Escutar áudio gravado"
        bigPlay.accessibilityLanguage = "pt-BR"
    }
    
    /**
     *Set accessibility to send an audio*
     - Parameters:
        - sendButton: The send button
     - returns: Nothing
     */
    static func sendButton(sendButton: UIButton) {
        sendButton.isAccessibilityElement = true
        sendButton.accessibilityTraits = UIAccessibilityTraits.button
        sendButton.accessibilityValue = "Enviar áudio gravado para a base de dados"
        sendButton.accessibilityLanguage = "pt-BR"
    }
    
    /**
     *Set accessibility to delete an audio*
     - Parameters:
        - garbageButton: The garbage button
     - returns: Nothing
     */
    static func garbageButton(garbageButton: UIButton) {
        garbageButton.isAccessibilityElement = true
        garbageButton.accessibilityTraits = UIAccessibilityTraits.button
        garbageButton.accessibilityValue = "Deletar áudio gravado"
        garbageButton.accessibilityLanguage = "pt-BR"
    }
    
    /**
     *Set accessibility to know the total recorded audio time*
     - Parameters:
        - totalTime: The total time
     - returns: Nothing
     */
    static func totalTime(totalTime: UILabel) {
        totalTime.isAccessibilityElement = true
        totalTime.accessibilityTraits = UIAccessibilityTraits.none
        totalTime.accessibilityValue = "Tempo total de áudio gravado"
        totalTime.accessibilityLanguage = "pt-BR"
    }
    
    /**
     *Set accessibility to stop recording*
     - Parameters:
        - stopRecording: The audio
     - returns: Nothing
     */
    static func stopRecording(stopRecording: UIButton) {
        stopRecording.isAccessibilityElement = true
        stopRecording.accessibilityTraits = UIAccessibilityTraits.button
        stopRecording.accessibilityValue = "Parar de gravar"
        stopRecording.accessibilityLanguage = "pt-BR"
    }
    
    /**
     *Set accessibility to back a screen*
     - Parameters:
        - backButton: The button
     - returns: Nothing
     */
    static func backButton(backButton: UIButton) {
        backButton.isAccessibilityElement = true
        backButton.accessibilityTraits = UIAccessibilityTraits.button
        backButton.accessibilityValue = "Voltar para a tela anterior"
        backButton.accessibilityLanguage = "pt-BR"
        backButton.accessibilityHint = "É recomendado caso você queira ir para uma outra obra ou gravar algum áudio"
    }
    
    /**
     *Set accessibility to record an audio*
     - Parameters:
        - startRecording: The audio
     - returns: Nothing
     */
    static func startRecording(startRecording: UIButton) {
        startRecording.isAccessibilityElement = true
        startRecording.accessibilityTraits = UIAccessibilityTraits.button
        startRecording.accessibilityValue = "Gravar um áudio"
        startRecording.accessibilityLanguage = "pt-BR"
    }
    
    /**
     *Set accessibility to know the current time*
     - Parameters:
        - currentTime: Total audio time
     - returns: Nothing
     */
    static func currentTimeAccessibility(currentTime: UILabel) {
        currentTime.isAccessibilityElement = true
        currentTime.accessibilityTraits = UIAccessibilityTraits.none
        currentTime.accessibilityValue = "Tempo atual do áudio"
        currentTime.accessibilityLanguage = "pt-BR"
    }
    
    /**
     *Set accessibility to know how many audios are available*
     - Parameters:
        - audioCounter: The counter label to show the total time
     - returns: Nothing
     */
    static func audioCounterAccessibility(audioCounter: UILabel) {
        audioCounter.isAccessibilityElement = true
        audioCounter.accessibilityTraits = UIAccessibilityTraits.staticText
        audioCounter.accessibilityValue = "Áudios disponíveis"
        audioCounter.accessibilityLanguage = "pt-BR"
    }
    
    /**
     *Set accessibility to listen to another audio *
     - Parameters:
        - nextOutlet: Next audio image
     - returns: Nothing
     */
    static func nextButtonAccessibility(nextOutlet: UIImageView) {
        nextOutlet.isAccessibilityElement = true
        nextOutlet.accessibilityTraits = UIAccessibilityTraits.button
        nextOutlet.accessibilityLabel = "Escutar o próximo áudio"
        nextOutlet.accessibilityLanguage = "pt-BR"
    }
    
    /**
     *Set accessibility to play or pause an audio and to change the image*
     - Parameters:
        - pauseButtonOutlet: The pause button
        - pause: The pause image
     - returns: Nothing
     */
    static func playPauseButtonAccessibility (pauseButtonOutlet: UIButton, pause: UIImageView) {
        switch isPlaying {
        case true:
            pause.image = UIImage.init(named: "play")
            StreamingSingleton.shared.stopPlaying()
            isPlaying = false
            pauseButtonOutlet.isAccessibilityElement = true
            pauseButtonOutlet.accessibilityTraits = UIAccessibilityTraits.button
            pauseButtonOutlet.accessibilityLanguage = "pt-BR"
            pauseButtonOutlet.accessibilityLabel = "Escutar áudio"
        case false:
            pause.image = UIImage.init(named: "pause")
            StreamingSingleton.shared.play()
            isPlaying = true
            pauseButtonOutlet.isAccessibilityElement = true
            pauseButtonOutlet.accessibilityTraits = UIAccessibilityTraits.button
            pauseButtonOutlet.accessibilityLanguage = "pt-BR"
            pauseButtonOutlet.accessibilityLabel = "Pausar áudio"
        }
    }
}
