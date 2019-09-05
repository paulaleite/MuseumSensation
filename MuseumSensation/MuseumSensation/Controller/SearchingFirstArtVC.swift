//
//  SearchingFirstArtVC.swift
//  MuseumSensation
//
//  Created by Paula Leite on 23/08/19.
//  Copyright © 2019 Paula Leite. All rights reserved.
//

import UIKit

class SearchingFirstArtVC: UIViewController {
    @IBOutlet weak var appleLogo: UIImageView!
    @IBOutlet weak var nextPageButtonOutlet: UIButton!
    
    @IBAction func nextPageButton(_ sender: Any) {
        fadeNavigation(target: MainArtVC())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Manager.centerIcon(iconImage: appleLogo)
        Manager.buttonOnView(button: nextPageButtonOutlet, image: appleLogo)
    }
}
