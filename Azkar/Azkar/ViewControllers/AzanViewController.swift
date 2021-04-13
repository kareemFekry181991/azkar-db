//
//  AzanViewController.swift
//  Azkar
//
//  Created by Kareem on 1/4/21.
//  Copyright © 2021 Kareem. All rights reserved.
//

import UIKit
import Adhan
import FirebaseAnalytics

struct AzanTimes {
    var name : String?
    var azanTime : String?
    init(name:String , azanTime:String) {
        self.name = name
        self.azanTime = azanTime
    }
}

class AzanViewController: UIViewController {
    
    @IBOutlet weak var timeCountDownLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var azanRemainView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var azanName: UILabel!
    @IBOutlet weak var azanTableView: UITableView! {
        didSet {
            azanTableView.dataSource = self
            azanTableView.delegate = self
        }
    }
    

    var timeFormat: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter
    }
    
   var times: PrayerTimes?
   private var currentDate: Date = Date()
   private var toDate: Date = Date()


    var coordinates : Coordinates?
    let formatter = DateFormatter()
    var azanTimeArr : [AzanTimes]? = []
    var timer = Timer()
    var seconds = 50
    var remainingTime = ""
    var countdown = Date()
    var countDownAm = ""
//    var azanTimes = ["05:21 am" , "06:52 am" , "12:04 pm" , "02:56 pm" , "5:15 pm", "06:37 pm"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAdhan()
        azanRemainView.applyShadow(cornerRadius: 15)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        timeCountDownLabel.text = ""
        Analytics.setScreenName("Azan Screen", screenClass: "AzanViewController")

    }

    func countDownString(for date: Date) -> String {
           let calendar = Calendar(identifier: .gregorian)
           let components = calendar
               .dateComponents([.hour, .minute, .second],
                               from: currentDate,
                               to: toDate)
           return String(format: "%02d:%02d:%02d",
                         components.hour ?? 00,
                         components.minute ?? 00,
                         components.second ?? 00)
 }
    func timeString(date: Date) -> String {
        let time = timeFormat.string(from: date)
        return time
    }

    func setupAdhan() {
        var localTimeZoneIdentifier: String { return TimeZone.current.identifier }
        print(localTimeZoneIdentifier)
        let cal = Calendar(identifier: Calendar.Identifier.gregorian)
        let date = cal.dateComponents([.year, .month, .day], from: Date())
        if UserStatus.latitude == 0 || UserStatus.longtitude == 0 {
            self.coordinates = Coordinates(latitude:  30.033333, longitude:  31.233334)
        } else {
            self.coordinates = Coordinates(latitude: UserStatus.latitude ?? 30.033333, longitude: UserStatus.longtitude ?? 31.233334)
        }
        var params = CalculationMethod.egyptian.params
        params.madhab = .shafi
        if let prayers = PrayerTimes(coordinates: self.coordinates! , date: date, calculationParameters: params) {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            formatter.timeZone = TimeZone(identifier: localTimeZoneIdentifier)
            print("fajr \(formatter.string(from: prayers.fajr))")
            print("sunrise \(formatter.string(from: prayers.sunrise))")
            print("dhuhr \(formatter.string(from: prayers.dhuhr))")
            print("asr \(formatter.string(from: prayers.asr))")
            print("maghrib \(formatter.string(from: prayers.maghrib))")
            print("isha \(formatter.string(from: prayers.isha))")
            self.azanTimeArr?.insert(AzanTimes(name: "الفجر" , azanTime: formatter.string(from: prayers.fajr)), at: 0)
            self.azanTimeArr?.insert(AzanTimes(name: "الشروق" , azanTime: formatter.string(from: prayers.sunrise)), at: 1)
            self.azanTimeArr?.insert(AzanTimes(name: "الظهر" , azanTime: formatter.string(from: prayers.dhuhr)), at: 2)
            self.azanTimeArr?.insert(AzanTimes(name: "العصر" , azanTime: formatter.string(from: prayers.asr)), at: 3)
            self.azanTimeArr?.insert(AzanTimes(name: "المغرب" , azanTime: formatter.string(from: prayers.maghrib)), at: 4)
            self.azanTimeArr?.insert(AzanTimes(name:  "العشاء" , azanTime: formatter.string(from: prayers.isha)), at: 5)
            let next = prayers.nextPrayer()
             countdown = prayers.time(for: next ?? Prayer.fajr)
            self.azanName.text = "\(next ?? Prayer.fajr)"
            
            let today = Date()
            let formatter1 = DateFormatter()
            formatter1.dateFormat =  "HH:mm:ss"
            print(self.countDownString(for: countdown))
            let formatterr = DateFormatter()
            formatter.dateStyle = .short
            self.countDownAm = "\(formatterr.string(from: self.countdown))"
            let formatter2 = DateComponentsFormatter()
            formatter2.unitsStyle = .positional
            formatter2.allowedUnits = [.hour, .minute, .second]
            formatter2.zeroFormattingBehavior = .pad
            remainingTime = formatter2.string(from: countdown , to: today) ?? ""
            
            
            let remainingDate = formatter1.date(from: remainingTime)
            timeUntilNextPrayer(countdown)
            self.timeLabel.text = "\(formatter.string(from: countdown))"
        }
    }
    
    
    

    func timeUntilNextPrayer(_ nextPrayer: Date) {
        var difference = DateComponents()
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
        difference = Calendar.current.dateComponents([.hour, .minute, .second ], from: Date(), to: nextPrayer)
            print(difference)
            let formatter1 = DateFormatter()
            formatter1.dateFormat = "HH:mm"
            let next = formatter1.string(from: nextPrayer)
            let formatter2 = DateComponentsFormatter()
            formatter2.unitsStyle = .positional
            formatter2.allowedUnits = [.hour, .minute, .second ]
            formatter2.zeroFormattingBehavior = .pad

//            if self.azanName.text == "fajr" {
//                if next <= "12:00"   {
//                    self.timeCountDownLabel.text = "\(formatter2.string(from: difference) ?? "")"
//                } else {
////                    let diff = formatter1.string(from: difference)
                    self.timeCountDownLabel.text = "\(formatter2.string(from: difference) ?? "")"
//                }
//            }
            
            
           
            if nextPrayer == Date() {
                timer.invalidate()
            }
        }
    }

}

extension AzanViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.azanTimeArr?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AzanTableViewCell", for: indexPath) as! AzanTableViewCell
        cell.azanNameLabel.text = self.azanTimeArr?[indexPath.row].name
        cell.AzanTimeLabel.text = self.azanTimeArr?[indexPath.row].azanTime
        return cell
    }
}


extension AzanViewController : UITextFieldDelegate {
    func runTimer() {
        
        timer = Timer.scheduledTimer(timeInterval: 1 , target: self,   selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
    }
    @objc func updateTimer() {
        seconds -= 1
        if seconds <= 0 {
            self.timeCountDownLabel.text = "0"
            self.timer.invalidate()
            return
        }else {
            self.timeCountDownLabel.text = "\(seconds)"
        }
    }
}

extension String {
    func convertToTimeInterval() -> TimeInterval {
        guard self != "" else {
            return 0
        }
        var interval:Double = 0
        let parts = self.components(separatedBy: ":")
        for (index, part) in parts.reversed().enumerated() {
            interval += (Double(part) ?? 0) * pow(Double(60), Double(index))
        }

        return interval
    }
}

extension UIView {

    func applyShadow(cornerRadius:CGFloat? = 30) {
    self.layer.cornerRadius = cornerRadius ?? 30
    self.layer.shadowRadius = 5
    self.layer.shadowOffset = .init(width: 1 , height: 1)
    self.layer.shadowColor = UIColor.lightGray.cgColor
    self.layer.shadowOpacity = 0.4
//    self.layer.shadowOpacity = 0.8
    self.layer.masksToBounds = false
    self.layer.shouldRasterize = true
    self.layer.rasterizationScale = UIScreen.main.scale
    }
}
extension Date {
    func adding(hours: Int) -> Date {
        return Calendar.current.date(byAdding: .hour, value: hours, to: self)!
    }
}
