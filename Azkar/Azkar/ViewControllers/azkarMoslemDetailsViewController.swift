//
//  azkarMoslemDetailsViewController.swift
//  Azkar
//
//  Created by Kareem on 12/30/20.
//  Copyright © 2020 Kareem. All rights reserved.
//

import UIKit
import FirebaseAnalytics

enum FontSize {
    case minimum
    case middle
    case large
}
class azkarMoslemDetailsViewController: UIViewController {
    
    @IBOutlet weak var azkarNameLabel: UILabel!
    @IBOutlet weak var azkarDetailsTableView: UITableView! {
        didSet {
            azkarDetailsTableView.dataSource = self
            azkarDetailsTableView.delegate = self
            
        }
    }
    var fontSize : FontSize? = .minimum
    var azkarData: [AzkarData]? = []
    var azkarName = ""
    var counter = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        HelperMethods.removeNavColor(navCon: self.navigationController ?? UINavigationController())
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        HelperMethods.reverseNavColor(nav: self.navigationController ?? UINavigationController())
        Analytics.setScreenName("Azkar Details Screen", screenClass: "azkarMoslemDetailsViewController")
        self.title = azkarName
        self.azkarNameLabel.text = "أحسنت لقد انتهيت من \(azkarName)"
        self.azkarNameLabel.isHidden = true
    }
    
    @IBAction func changeFontSizeClicked(_ sender: UIBarButtonItem) {
        counter += 1
        if counter == 1 {
            self.fontSize = .minimum
        } else if counter == 2 {
            self.fontSize = .middle
        } else {
            self.fontSize = .large
            counter = 0
        }
        self.azkarDetailsTableView.reloadData()
    }
    
    @IBAction func backClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK:- UITableViewDelegate
extension azkarMoslemDetailsViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.azkarData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "azkarDetailsTableViewCell", for: indexPath) as! azkarDetailsTableViewCell
        
        
        switch self.fontSize {
        case .minimum:
            cell.zekrLabel.font =   UIFont(name: "ElMessiri-SemiBold", size: 16)
            break
        case .middle :
            cell.zekrLabel.font =   UIFont(name: "ElMessiri-SemiBold", size: 18)
            break
        case .large:
            cell.zekrLabel.font =   UIFont(name: "ElMessiri-SemiBold", size: 20)
        break
        default:
            break
    }
        
        print("Fonttttt\(self.fontSize)")
        
        cell.zekrLabel.text = self.azkarData?[indexPath.row].zekr ?? ""
        if self.azkarData?[indexPath.row].count == "" {
//            cell.sayingCountLabel.isHidden  = true
            cell.sayingCountLabel.text = "تكرار: " + "-"
        } else {
            cell.sayingCountLabel.isHidden  = false
            cell.sayingCountLabel.text = "التكرار   " + (self.azkarData?[indexPath.row].count ?? "")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.azkarData?[indexPath.row].count != "" {
            guard var tapCounter = Int(self.azkarData?[indexPath.row].count ?? "") else { return }
            tapCounter -= 1
            if tapCounter == 0 {
                self.azkarData?.remove(at: indexPath.row)
                self.azkarDetailsTableView.reloadData()
                if self.azkarData?.count == 0 {
                    self.azkarNameLabel.isHidden = false
                }
                return
            }
            self.azkarData?[indexPath.row].count = "\(tapCounter)"
            self.azkarDetailsTableView.reloadData()
        }
    }
}

