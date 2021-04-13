//
//  SettingsViewController.swift
//  Azkar
//
//  Created by Kareem on 1/4/21.
//  Copyright © 2021 Kareem. All rights reserved.
//

import UIKit
import Adhan
import UserNotifications
import FirebaseAnalytics

class SettingsViewController: UIViewController {

    let formatter = DateFormatter()
    let appLink = "https://apps.apple.com/us/app/%D8%B2%D8%A7%D8%AF-%D8%A7%D9%84%D9%85%D8%B3%D9%84%D9%85/id1556036269"
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Analytics.setScreenName("Settings Screen", screenClass: "SettingsViewController")
    }


    @IBAction func shareLinkWithFaceBook(_ sender: UIButton) {
        if let name = URL(string: self.appLink), !name.absoluteString.isEmpty {
          let objectsToShare = [name]
          let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
          self.present(activityVC, animated: true, completion: nil)
        } else {
          // show alert for not available
        }

    }
    @IBAction func shareLinkWithWhatsapp(_ sender: UIButton) {
        let message = "&\(appLink)"
        var queryCharSet = NSCharacterSet.urlQueryAllowed

        // if your text message contains special char like **+ and &** then add this line
        queryCharSet.remove(charactersIn: "+&")
        if let escapedString = message.addingPercentEncoding(withAllowedCharacters: queryCharSet) {
            if let whatsappURL = URL(string: "whatsapp://send?text=\(escapedString)") {
                if UIApplication.shared.canOpenURL(whatsappURL) {
                    UIApplication.shared.open(whatsappURL, options: [: ], completionHandler: nil)
                } else {
                    debugPrint("please install WhatsApp")
                }
            }
    }
}
    @IBAction func copyLink(_ sender: UIButton) {
        UIPasteboard.general.string = self.appLink
        showAlertAction(title: "", message: "لقد تم نسخ رابط التطبيق")
    }
}
extension SettingsViewController {
    func showAlertAction(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "حسنا", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction!) in
            print("Action")
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
