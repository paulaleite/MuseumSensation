//
//  ObraCodable.swift
//  MuseumSensation
//
//  Created by Paula Leite on 02/09/19.
//  Copyright © 2019 Paula Leite. All rights reserved.
//

import Foundation
import UIKit

struct ObraCodable: Codable {
    var beacon: String?
    var titulo: String?
    var autor: String?
    var descricao: String?
    var estado: Bool?
    var imagem: String?
    var audios: [AudioCodable]?
    
}

struct AudioCodable: Codable {
    var nome: String?
    var isAproved: Bool?
    var isCurador: Bool?
}

class InternObra: NSObject {
    static func getNomeObra(obraID: String) -> ObraCodable {
        var obra: ObraCodable?
        
        do {
            let path = "https://br-museum-sensation.herokuapp.com/obra/" + obraID
            guard let url = URL(string: path) else {
                return ObraCodable()
                
            }
            
            let obraData = try Data(contentsOf: url)
            obra = try JSONDecoder().decode(ObraCodable.self, from: obraData)
            // aqui entra a parte em que ele vai salvar no codigo
            guard let obra = obra else {
                return ObraCodable()
                
            }
            return obra
            
        } catch {
            print("\(error.localizedDescription)")
        }
        guard let safeObra = obra else {
            return ObraCodable()
            
        }
        return safeObra
        
    }
    
}

class InterAudio: NSObject {
    static func getAudio(audioNome: String) -> AudioCodable {
        var audio: AudioCodable?
        
        do {
            let path = "https://br-museum-sensation.herokuapp.com/audioStream/\(audioNome)"
            guard let url = URL(string: path) else {
                return AudioCodable()
            }
            
            let audioData = try Data(contentsOf: url)
            audio = try JSONDecoder().decode(AudioCodable.self, from: audioData)
            guard let audio = audio else {
                return AudioCodable()
                
            }
            return audio
            
        } catch {
            print("\(error.localizedDescription)")
        }
        guard let safeAudio = audio else {
            return AudioCodable()
            
        }
        return safeAudio
    }
    
    static func getAudios(obraID: String) -> [AudioCodable] {
        var audios: [AudioCodable]?
        
        do {
            let path = "https://br-museum-sensation.herokuapp.com/audios/\(obraID)"
            guard let url = URL(string: path) else {
                return [AudioCodable()]
            }
            
            let audioData = try Data(contentsOf: url)
            audios = try JSONDecoder().decode([AudioCodable].self, from: audioData)
            guard let audios = audios else {
                return [AudioCodable()]
                
            }
            return audios
            
        } catch {
            print("\(error.localizedDescription)")
        }
        guard let safeAudios = audios else {
            return [AudioCodable()]
            
        }
        return safeAudios
    }
    
    static func postAudio(audioNome: String, completion: @escaping ([String: Any]?, Error?) -> Void) {
        
        let group = DispatchGroup() // initialize the async
        group.enter()
        let audio = ["nome": audioNome] as [String: Any]
        let audioParams = ["beacon": "\(ImageSingleton.shared.getCurrentImage())",
                        "audio": audio] as [String: Any]
        
        guard let url = URL(string: "https://br-museum-sensation.herokuapp.com/createAudio/") else {
            return
        }
        
        //create the session object
        let session = URLSession.shared
        
        //now create the Request object using the url object
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST" //set http method as POST
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: audioParams, options: .prettyPrinted) // pass dictionary to data object and set it as request body
        } catch let error {
            print(error.localizedDescription)
            completion(nil, error)
        }
        
        //HTTP Headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Acadresst")
        
        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request, completionHandler: { data, _, error in
            group.leave()
            
            group.notify(queue: .main, execute: {
                guard error == nil else {
                    completion(nil, error)
                    return
                }
                
                guard data != nil else {
                    completion(nil, NSError(domain: "dataNilError", code: -100001, userInfo: nil))
                    return
                }
                
                do {
                    if let file = data {
                        let json = try JSONSerialization.jsonObject(with: file, options: []) as? [String: Any] ?? [String: Any] ()
                        print(json)
                        for (key, value) in json {
                            if key == "result" {
                                if value as? Int == 0 {
                                    completion(nil, nil)
                                } else {
                                    completion(json, nil)
                                }
                            } else {
                                completion(nil, nil)
                            }
                        }
                        
                    } else {
                        // No file
                        
                    }
                    
                } catch {
                    print(error.localizedDescription)
                    
                }
            })
            
        })
        
        task.resume()
    }
}
