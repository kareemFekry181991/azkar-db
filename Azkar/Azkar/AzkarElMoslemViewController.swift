//
//  ViewController.swift
//  Azkar
//
//  Created by Kareem on 12/27/20.
//  Copyright © 2020 Kareem. All rights reserved.
//

import UIKit

class AzkarElMoslemViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let azkarData = HelperMethods.readLocalFile(forName: "azkar") ?? Data()
        self.parse(jsonData: azkarData)
    }
    
    func parse(jsonData: Data) {
        do {
            let decodedData = try JSONDecoder().decode([AzkarModel].self,
                                                       from: jsonData)
            print("===================================\(decodedData.count)")
            print("===================================")
        } catch {
            print("decode error")
        }
    }
    
 }

