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

    @IBOutlet weak var compassArrow: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.makeQiblaDirections()

    }
}

extension QiblaViewController {
    func makeQiblaDirections() {
        let myCoordinates = Coordinates(latitude: UserStatus.latitude ?? 0, longitude: UserStatus.longtitude ?? 0)
        let qibla = Qibla(coordinates: myCoordinates).direction
        let radians = qibla * (.pi/180)
        compassArrow.transform = CGAffineTransform(rotationAngle: CGFloat(radians))
    }
}
