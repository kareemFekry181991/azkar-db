//
//  HelperMethods.swift
//  Azkar
//
//  Created by Kareem on 12/27/20.
//  Copyright © 2020 Kareem. All rights reserved.
//

import Foundation

class HelperMethods {
    class func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        
        return nil
    }
    
}
