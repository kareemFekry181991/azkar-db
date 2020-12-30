//
//  azkarMoslemDetailsViewController.swift
//  Azkar
//
//  Created by Kareem on 12/30/20.
//  Copyright © 2020 Kareem. All rights reserved.
//

import UIKit

class azkarMoslemDetailsViewController: UIViewController {
   
    @IBOutlet weak var azkarDetailsTableView: UITableView! {
        didSet {
            azkarDetailsTableView.dataSource = self
            azkarDetailsTableView.delegate = self
            
        }
    }
    var azkarData: [AzkarData]? = []
   
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
 

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
}
