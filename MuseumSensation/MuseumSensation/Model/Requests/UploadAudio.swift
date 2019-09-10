//
//  UploadAudio.swift
//  MuseumSensation
//
//  Created by Paula Leite on 02/09/19.
//  Copyright © 2019 Paula Leite. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

func myAudioUploadRequest(_ audioFileName: URL, _ nameOfAudioForToSave: String) {
    
    guard let myURL = URL(string: "https://br-museum-sensation.herokuapp.com/upload") else {
        return
    }
    var request = URLRequest(url: myURL)
    request.httpMethod = "POST"
    
    do {
        
        let boundary = generateBoundaryString()
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        

        guard let url = Bundle.main.url(forResource: "audio", withExtension: "m4a") else {
            return
        }
        
        let audioData = try Data(contentsOf: url)
        
        var body = Data()
        body = createBodyWithParameters(nil, "imgUploader", audioData, boundary, nameOfAudioForToSave)
        request.httpBody = body
        
    } catch let error {
        print(error.localizedDescription)
    }
    
    let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
        do {
            if let data = data {
                let response = try JSONSerialization.jsonObject(with: data, options: [])
                print(response)
            } else {
                // Data is nil.
            }
        } catch let error as NSError {
            print("json error: \(error.localizedDescription)")
        }
    }
    task.resume()
}

func generateBoundaryString() -> String {
    return "Boundary-\(NSUUID().uuidString)"
}

func createBodyWithParameters(_ parameters: [String: String]?, _ filePathKey: String?, _ imageDataKey: Data, _ boundary: String, _ nameOfImageForToSave: String) -> Data {
    var body = Data()
    
    if parameters != nil {
        guard let parameters = parameters else {
            return Data()
        }
        for (key, value) in parameters {
            body.appendString("--\(boundary)\r\n")
            body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
            body.appendString("\(value)\r\n")
        }
    }
    
    let filename = nameOfImageForToSave
    let mimetype = "image/jpeg"
    
    body.appendString("--\(boundary)\r\n")
    guard let filePathKey = filePathKey else {
        return Data()
    }
    body.appendString("Content-Disposition: form-data; name=\"\(filePathKey)\"; filename=\"\(filename)\"\r\n")
    
    body.appendString("Content-Type: \(mimetype)\r\n\r\n")
    body.append(imageDataKey)
    body.appendString("\r\n")
    body.appendString("--\(boundary)--\r\n")
    return body
}

extension Data {
    mutating func appendString(_ string: String) {
        let data = string.data(
            using: String.Encoding.utf8,
            allowLossyConversion: true)
        
        guard let safeData = data else {
            return
        }
        
        append(safeData)
    }
}
