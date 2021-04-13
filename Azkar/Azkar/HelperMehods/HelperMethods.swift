//
//  HelperMethods.swift
//  Azkar
//
//  Created by Kareem on 12/27/20.
//  Copyright © 2020 Kareem. All rights reserved.
//

import Foundation
import UIKit

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
    
    
    class func reverseNavColor(nav:UINavigationController) {
        nav.navigationBar.setBackgroundImage(nil, for: .default)
        nav.navigationBar.shadowImage = nil
        nav.navigationBar.barTintColor = #colorLiteral(red: 0.2612861097, green: 0.5247141123, blue: 0.7656573653, alpha: 1)
        nav.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white , NSAttributedString.Key.font: UIFont(name:"ElMessiri-SemiBold" , size: 18) ?? UIFont.systemFont(ofSize: 18)]
        nav.navigationBar.isTranslucent = false
        nav.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    class func removeNavColor(navCon:UINavigationController) {
        navCon.navigationBar.setBackgroundImage(nil, for: .default)
        navCon.navigationBar.shadowImage = nil
        navCon.navigationBar.barTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navCon.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white , NSAttributedString.Key.font: UIFont(name:"Cairo-SemiBold" , size: 18) ?? UIFont.systemFont(ofSize: 18)]
        navCon.navigationBar.isTranslucent = false
        navCon.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navCon.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navCon.navigationBar.shadowImage = UIImage()

    }

}
