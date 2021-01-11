//
//  ViewController.swift
//  Azkar
//
//  Created by Kareem on 12/27/20.
//  Copyright © 2020 Kareem. All rights reserved.
//

import UIKit
import Adhan
import CoreLocation


class AzkarElMoslemViewController: UIViewController {
    
    @IBOutlet weak var azkarTableView: UITableView! {
        didSet {
            azkarTableView.dataSource = self
            azkarTableView.delegate = self
        }
    }
    
    var azkar  : [Azkar]? = []
    var locationManager = CLLocationManager()
    var mapLat = CLLocationDegrees()
    var mapLng = CLLocationDegrees()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.getCurrentLocation()
       
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
        scene.azkarName = self.azkar?[indexPath.row].category ?? ""
        self.navigationController?.pushViewController(scene , animated: true)
    }
}


//MARK:- Schedule Prayer times
extension AzkarElMoslemViewController {
    func schedulePrayerTimes() {
        let center =  UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        let content = UNMutableNotificationContent()
        content.title = "الآذان"
        content.subtitle = "It looks hungry"
        content.body = "Some message"
        //        content.sound = UNNotificationSound.default
        let soundName = UNNotificationSoundName("azan.mp3")
        content.sound = UNNotificationSound(named: soundName)
        // show this notification five seconds from now
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60 , repeats: true)
        // choose a random identifier
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        print(request)
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
                        //                        self.schedulePrayerTimes()
                        
                        
                        var localTimeZoneIdentifier: String { return TimeZone.current.identifier }
                        print(localTimeZoneIdentifier)
                        let cal = Calendar(identifier: Calendar.Identifier.gregorian)
                        let date = cal.dateComponents([.year, .month, .day], from: Date())
                        let coordinates = Coordinates(latitude: self.mapLat , longitude: self.mapLng)
                        var params = CalculationMethod.moonsightingCommittee.params
                        params.madhab = .hanafi
                        if let prayers = PrayerTimes(coordinates: coordinates, date: date, calculationParameters: params) {
                            let formatter = DateFormatter()
                            formatter.timeStyle = .short
                            formatter.timeZone = TimeZone(identifier: localTimeZoneIdentifier)
                            
                            print("fajr \(formatter.string(from: prayers.fajr))")
                            print("sunrise \(formatter.string(from: prayers.sunrise))")
                            print("dhuhr \(formatter.string(from: prayers.dhuhr))")
                            print("asr \(formatter.string(from: prayers.asr))")
                            print("maghrib \(formatter.string(from: prayers.maghrib))")
                            print("isha \(formatter.string(from: prayers.isha))")
                            
                            self.scheduleNotification(notificationType: "حان الآن موعد صلاة الفجر",time: formatter.string(from: prayers.fajr)  , identifier:  UUID().uuidString)
                            self.scheduleNotification(notificationType: "حان الآن موعد صلاة الشروق",time: formatter.string(from: prayers.sunrise) , identifier: UUID().uuidString)
                            self.scheduleNotification(notificationType:  "حان الآن موعد صلاة الظهر",time: formatter.string(from: prayers.dhuhr) , identifier:  UUID().uuidString)
                            self.scheduleNotification(notificationType:  "حان الآن موعد صلاة العصر" ,time: formatter.string(from: prayers.asr) , identifier: UUID().uuidString)
                            self.scheduleNotification(notificationType:  "حان الآن موعد صلاة المغرب" ,time: formatter.string(from: prayers.maghrib) , identifier:  UUID().uuidString)
                            self.scheduleNotification(notificationType:  "حان الآن موعد صلاة العشاء" ,time: formatter.string(from: prayers.isha) , identifier:  UUID().uuidString)
                        }
                        
                    } else if let error = error {
                        print(error.localizedDescription)
                    }
                }
                
            } else {
                print("No")
            }
        }
    }
    
    func schedulePrayers(notificationTitle: String , time: String , identifier:String) {
        let center =  UNUserNotificationCenter.current()
        //        center.removeAllPendingNotificationRequests()
        let content = UNMutableNotificationContent()
        content.title = notificationTitle
        content.subtitle = "It looks hungry"
        content.body = "Some message"
        //        content.sound = UNNotificationSound.default
        let soundName = UNNotificationSoundName("azan.mp3")
        content.sound = UNNotificationSound(named: soundName)
        // show this notification five seconds from now
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60 , repeats: true)
        // choose a random identifier
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        print(request)
        // add our notification request
        center.add(request)
        
    }
}
extension AzkarElMoslemViewController {
    
    func scheduleNotification(notificationType: String,time: String , identifier:String) {
        let center =  UNUserNotificationCenter.current()
//        center.removeAllPendingNotificationRequests()
        let content = UNMutableNotificationContent()
        let startTime = time
        let fmt = DateFormatter()
        fmt.dateFormat = "h:mm a"
        let dateFrom = fmt.date(from: startTime)!
        content.title = notificationType
        content.body = "الله اكبر الله اكبر لا اله الا الله"
        let soundName = UNNotificationSoundName("azan.mp3")
        content.sound = UNNotificationSound(named: soundName)
        //        let date = Date(timeIntervalSinceNow: 3600)
        let triggerDaily = Calendar.current.dateComponents([.hour,.minute,.second,], from: dateFrom)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDaily, repeats: true)
        let identifier = identifier
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        center.add(request)
    }
}
extension AzkarElMoslemViewController {
    func setupLocationManager() {
        //        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        } else {
            //                self.showAlertWith(title: "Warning", msg:  "You have to turn Location setting".localized , type: .warning )
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func updateLocation() {
        //        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    
    func checkLocationAuthorization() {
        
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            dismiss(animated: true, completion: nil)
            self.updateLocation()
            break
        case .denied:
            // Show alert instructing them how to turn on permissions
            
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            // Show an alert letting them know what's up
            break
        case .authorizedAlways:
            self.updateLocation()
            break
        @unknown default:
            fatalError()
        }
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.last
        {
            self.mapLat = location.coordinate.latitude
            self.mapLng = location.coordinate.longitude
            self.addNotification()
            // make map view animated
            self.locationManager.stopUpdatingLocation()
        }
    }
}
//MARK:- CLLocationManagerDelegate
extension AzkarElMoslemViewController : CLLocationManagerDelegate {
    func getCurrentLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        if CLLocationManager.locationServicesEnabled() {
            switch (CLLocationManager.authorizationStatus()) {
            case .notDetermined, .restricted, .denied:
                print("No access")
            case .authorizedAlways, .authorizedWhenInUse:
                print("Access")
            @unknown default:
                fatalError()
            }
        } else {
            print("Location services are not enabled")
        }
    }
    
}

