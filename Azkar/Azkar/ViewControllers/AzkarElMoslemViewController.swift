//
//  ViewController.swift
//  Azkar
//
//  Created by Kareem on 12/27/20.
//  Copyright © 2020 Kareem. All rights reserved.
//

import UIKit

class AzkarElMoslemViewController: UIViewController {

    @IBOutlet weak var azkarTableView: UITableView! {
        didSet {
            azkarTableView.dataSource = self
            azkarTableView.delegate = self
        }
    }
    var azkar  : [Azkar]? = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.addNotification()
        let azkarData = HelperMethods.readLocalFile(forName: "azkar") ?? Data()
        self.parse(jsonData: azkarData)
    }
    func parse(jsonData: Data) {
        do {
            let decodedData = try JSONDecoder().decode(AzkarModel.self,
                                            from: jsonData)
            print("===================================\(decodedData.data?.count ?? 0)")
            self.azkar = decodedData.data
            self.azkarTableView.reloadData()
            print("===================================")
        } catch {
            print("decode error")
        }
    }
    
 }

extension AzkarElMoslemViewController : UITableViewDelegate , UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.azkar?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "azkarMoslemTableViewCell", for: indexPath) as! azkarMoslemTableViewCell
        cell.TitleLabel.text = self.azkar?[indexPath.row].category ?? ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let scene = self.storyboard?.instantiateViewController(identifier: "azkarMoslemDetailsViewController") as! azkarMoslemDetailsViewController
        scene.azkarData =  self.azkar?[indexPath.row].data
        self.navigationController?.pushViewController(scene , animated: true)
    }
}


//MARK:- Schedule Prayer times
extension AzkarElMoslemViewController {
    func schedulePrayerTimes() {
        let center =  UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        let content = UNMutableNotificationContent()
        content.title = "Feed the cat"
        content.subtitle = "It looks hungry"
        content.body = "Some message"
//        content.sound = UNNotificationSound.default
        let soundName = UNNotificationSoundName("azan.mp3")
        content.sound = UNNotificationSound(named: soundName)
        // show this notification five seconds from now
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60 , repeats: true)
        // choose a random identifier
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        // add our notification request
        center.add(request)
    }
    
    
    func addNotification() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert]) {
            (granted, error) in
            if granted {
                print("yes")
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        print("All set!")
                        self.schedulePrayerTimes()
                    } else if let error = error {
                        print(error.localizedDescription)
                    }
                }
                
            } else {
                print("No")
            }
        }
    }

}
