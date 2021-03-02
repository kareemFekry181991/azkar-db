//
//  azkarSettingsViewController.swift
//  Azkar
//
//  Created by Kareem on 2/12/21.
//  Copyright © 2021 Kareem. All rights reserved.
//

import UIKit
import WWCalendarTimeSelector

class azkarSettingsViewController: UIViewController {

    @IBOutlet weak var azkarElMasaaLabel: UILabel!
    @IBOutlet weak var azakarElSabahTime: UILabel!
    var isAzkarSabahSelected = false
    override func viewDidLoad() {
        super.viewDidLoad()
        azkarElMasaaLabel.UIViewAction {
            self.isAzkarSabahSelected = false
            self.showCalendar()
        }
        azakarElSabahTime.UIViewAction {
            self.isAzkarSabahSelected = true
            self.showCalendar()
        }

    }

}
extension  azkarSettingsViewController : WWCalendarTimeSelectorProtocol {
    func showCalendar() {
        let selector = WWCalendarTimeSelector.instantiate()
        selector.optionStyles.showDateMonth(false)
        selector.optionStyles.showMonth(false)
        selector.optionStyles.showYear(false)
        selector.optionStyles.showTime(true)
        selector.delegate = self
        present(selector, animated: true, completion: nil)
       }
    
    func WWCalendarTimeSelectorDone(_ selector: WWCalendarTimeSelector, date: Date) {
        
        print("Selected \n\(date)\n---")
        if isAzkarSabahSelected {
            azakarElSabahTime.text = date.stringFromFormat("h:mma")
        } else {
            azkarElMasaaLabel.text = date.stringFromFormat("h:mma")
        }
   }

}

extension Date {
    func stringFromFormat(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.autoupdatingCurrent
        formatter.calendar = Calendar.autoupdatingCurrent
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
