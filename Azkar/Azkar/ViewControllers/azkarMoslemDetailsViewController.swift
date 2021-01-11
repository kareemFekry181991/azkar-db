//
//  azkarMoslemDetailsViewController.swift
//  Azkar
//
//  Created by Kareem on 12/30/20.
//  Copyright © 2020 Kareem. All rights reserved.
//

import UIKit

class azkarMoslemDetailsViewController: UIViewController {
    
    @IBOutlet weak var azkarNameLabel: UILabel!
    @IBOutlet weak var azkarDetailsTableView: UITableView! {
        didSet {
            azkarDetailsTableView.dataSource = self
            azkarDetailsTableView.delegate = self
            
        }
    }
    var azkarData: [AzkarData]? = []
    var azkarName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = azkarName
        self.azkarNameLabel.text = "أحسنت لقد انتهيت من \(azkarName)"
        self.azkarNameLabel.isHidden = true
    }
    
}

//MARK:- UITableViewDelegate
extension azkarMoslemDetailsViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.azkarData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "azkarDetailsTableViewCell", for: indexPath) as! azkarDetailsTableViewCell
        cell.zekrLabel.text = self.azkarData?[indexPath.row].zekr ?? ""
        if self.azkarData?[indexPath.row].count == "" {
            cell.sayingCountLabel.isHidden  = true
        } else {
            cell.sayingCountLabel.isHidden  = false
            cell.sayingCountLabel.text = "تكرار: " + (self.azkarData?[indexPath.row].count ?? "")
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

