//
//  AzanViewController.swift
//  Azkar
//
//  Created by Kareem on 1/4/21.
//  Copyright © 2021 Kareem. All rights reserved.
//

import UIKit
import Adhan

struct AzanTimes {
    var name : String?
    var azanTime : String?
    init(name:String , azanTime:String) {
        self.name = name
        self.azanTime = azanTime
    }
}

class AzanViewController: UIViewController {
    
    @IBOutlet weak var azanTableView: UITableView! {
        didSet {
            azanTableView.dataSource = self
            azanTableView.delegate = self
        }
    }
    let formatter = DateFormatter()
    var azanTimeArr : [AzanTimes]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAdhan()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    func setupAdhan() {
        var localTimeZoneIdentifier: String { return TimeZone.current.identifier }
        print(localTimeZoneIdentifier)
        let cal = Calendar(identifier: Calendar.Identifier.gregorian)
        let date = cal.dateComponents([.year, .month, .day], from: Date())
        let coordinates = Coordinates(latitude: 30.033333, longitude: 31.233334)
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
            self.azanTimeArr?.insert(AzanTimes(name: "الفجر" , azanTime: formatter.string(from: prayers.fajr)), at: 0)
            self.azanTimeArr?.insert(AzanTimes(name: "الشروق" , azanTime: formatter.string(from: prayers.sunrise)), at: 1)
            self.azanTimeArr?.insert(AzanTimes(name: "الظهر" , azanTime: formatter.string(from: prayers.dhuhr)), at: 2)
            self.azanTimeArr?.insert(AzanTimes(name: "العصر" , azanTime: formatter.string(from: prayers.asr)), at: 3)
            self.azanTimeArr?.insert(AzanTimes(name: "المغرب" , azanTime: formatter.string(from: prayers.maghrib)), at: 4)
            self.azanTimeArr?.insert(AzanTimes(name:  "العشاء" , azanTime: formatter.string(from: prayers.isha)), at: 5)
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

