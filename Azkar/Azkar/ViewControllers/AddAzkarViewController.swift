//
//  AddAzkarViewController.swift
//  Azkar
//
//  Created by Kareem on 12/28/20.
//  Copyright © 2020 Kareem. All rights reserved.
//

import UIKit
import FirebaseAnalytics

class AddAzkarViewController: UIViewController {
    @IBOutlet weak var azkaryTableView: UITableView! {
        didSet {
            azkaryTableView.dataSource = self
            azkaryTableView.delegate = self
        }
    }
    @IBOutlet weak var addAzakarView: UIView!
    @IBOutlet weak var azkaryTextView: UITextView!
    @IBOutlet weak var messageLabel: UILabel!
    
    
    var azkaryArr  : [String]? = []
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserStatus.azkaryArr?.count == 0 || UserStatus.azkaryArr == nil {
            azkaryTableView.isHidden = true
            self.messageLabel.isHidden = false
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Analytics.setScreenName("Add Azkar Screen", screenClass: "AddAzkarViewController")
    }


    //MARK:-    @IBAction
    @IBAction func AddClicked(_ sender: UIBarButtonItem) {
        self.azkaryTextView.layer.borderColor = UIColor.clear.cgColor
        addAzakarView.isHidden = false
    }
    @IBAction func CancelClicked(_ sender: UIButton) {
        addAzakarView.isHidden = true
    }
    @IBAction func AddAzkarClicked(_ sender: UIButton) {
        if !azkaryTextView.text.isEmpty {
            if UserStatus.azkaryArr?.count != 0 && UserStatus.azkaryArr != nil {
               self.azkaryArr = UserStatus.azkaryArr
            }
            self.azkaryArr?.append(self.azkaryTextView.text ?? "")
            UserStatus.azkaryArr = self.azkaryArr
            self.addAzakarView.isHidden = true
            self.azkaryTextView.text = ""
            self.azkaryTableView.isHidden = false
            self.azkaryTableView.reloadData()
            self.messageLabel.isHidden = true
        } else {
            self.azkaryTextView.layer.borderColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        }
    }
}

extension AddAzkarViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserStatus.azkaryArr?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AzkaryTableViewCell", for: indexPath) as! AzkaryTableViewCell
        cell.azkaryLabel.text =  UserStatus.azkaryArr?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            // handle delete (by removing the data from your array and updating the tableview)
             UserStatus.azkaryArr?.remove(object:  UserStatus.azkaryArr?[indexPath.row] ?? "")
            if UserStatus.azkaryArr?.count == 0 {
                self.messageLabel.isHidden = false
                self.azkaryArr = []
            }
            self.azkaryTableView.reloadData()
        }
    }
}


