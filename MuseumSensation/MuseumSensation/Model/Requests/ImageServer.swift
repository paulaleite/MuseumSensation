//
//  AudioServer.swift
//  MuseumSensation
//
//  Created by Paula Leite on 02/09/19.
//  Copyright © 2019 Paula Leite. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    public func imageFromServerURL(urlString: String, completion: @escaping (String?, Error?) -> Void) {
        self.image = nil
        let urlStringNew = urlString.replacingOccurrences(of: " ", with: "%20")
        guard let urlStringNewSafe = NSURL(string: urlStringNew) else { return }
        URLSession.shared.dataTask(with: urlStringNewSafe as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error as Any)
                completion(nil, error)
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                guard let data = data else { return }
                let image = UIImage(data: data)
                self.image = image
                completion("1", nil)
            })
            
        }).resume()
    }}
