//
//  QiblaViewController.swift
//  Azkar
//
//  Created by Kareem on 1/31/21.
//  Copyright © 2021 Kareem. All rights reserved.
//

import UIKit
import Adhan

class QiblaViewController: UIViewController {

    
    @IBOutlet weak var ivCompassBack: UIImageView!
    @IBOutlet weak var ivCompassNeedle: UIImageView!
    
    var compassManager  : CompassDirectionManager!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        compassManager =  CompassDirectionManager(dialerImageView: ivCompassBack, pointerImageView: ivCompassNeedle)
        compassManager.initManager()
    }
    @IBAction func dismissClicked(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true , completion: nil)
    }
}
