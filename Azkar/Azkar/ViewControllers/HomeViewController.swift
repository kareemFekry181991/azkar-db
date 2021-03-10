//
//  HomeViewController.swift
//  Azkar
//
//  Created by Kareem on 1/26/21.
//  Copyright © 2021 Kareem. All rights reserved.
//

import UIKit
import PDFReader
class HomeViewController: UIViewController {
    
    //MARK:-  @IBOutlet
    @IBOutlet weak var tasbeehLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var sobhanBtn: UIButton!
    @IBOutlet weak var elhamdBtn: UIButton!
    @IBOutlet weak var allahAkbarBtn: UIButton!
    @IBOutlet weak var highButton: UIButton!
    @IBOutlet weak var meduimBtn: UIButton!
    @IBOutlet weak var lowBtn: UIButton!
    @IBOutlet weak var rareBtn: UIButton!
    @IBOutlet weak var daysLabel: UILabel!
    
    //MARK:- ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customizeBtn(selectedBtn: sobhanBtn , firstBtn: elhamdBtn, secondBtn: allahAkbarBtn)
    }
    
    //MARK:- @IBAction
    
    @IBAction func settingClicked(_ sender: UIButton) {
    }
    @IBAction func hightBtnClicked(_ sender: UIButton) {
        customizeButton(selectedBtn: sender , firstBtn: self.lowBtn, secondBtn: self.meduimBtn , third: self.rareBtn)
    }
    @IBAction func mediumBtnClicked(_ sender: UIButton) {
        customizeButton(selectedBtn: sender , firstBtn: self.lowBtn, secondBtn: self.highButton , third: self.rareBtn)
        
    }
    @IBAction func lowBtnClicked(_ sender: UIButton) {
        customizeButton(selectedBtn: sender , firstBtn: self.meduimBtn, secondBtn: self.highButton , third: self.rareBtn)
        
    }
    @IBAction func rareBtnClicked(_ sender: UIButton) {
        customizeButton(selectedBtn: sender , firstBtn: self.meduimBtn, secondBtn: self.highButton , third: self.lowBtn)
        
    }
    @IBAction func sobhanAllahClicked(_ sender: UIButton) {
        customizeBtn(selectedBtn: sender , firstBtn: elhamdBtn, secondBtn: allahAkbarBtn)
        tasbeehLabel.text = "سبحان الله"
        countLabel.text = "33"
    }
    @IBAction func elhamdollelahClicked(_ sender: UIButton) {
        customizeBtn(selectedBtn: sender , firstBtn: sobhanBtn, secondBtn: allahAkbarBtn)
        tasbeehLabel.text = "الحمد لله"
        countLabel.text = "33"
    }
    @IBAction func QuraanKareemClicked(_ sender: UIButton) {
        let documentFileURL = Bundle.main.url(forResource: "quran_r", withExtension: "pdf")!
        let document = PDFDocument(url: documentFileURL)!
        let readerController = PDFViewController.createNew(with: document)
        let nav = UINavigationController(rootViewController: readerController)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true , completion: nil)
    }
    @IBAction func allahAkbarClicked(_ sender: UIButton) {
        customizeBtn(selectedBtn: sender , firstBtn: sobhanBtn, secondBtn: elhamdBtn)
        tasbeehLabel.text = "الله اكبر"
        countLabel.text = "33"
    }
    @IBAction func elQiblaClicked(_ sender: UIButton) {
        let qiblaViewController = self.storyboard?.instantiateViewController(identifier: "QiblaViewController") as! QiblaViewController
        let nav = UINavigationController(rootViewController: qiblaViewController)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true , completion: nil)
    }
    @IBAction func counterClicked(_ sender: UIButton) {
        guard var counter = Int(countLabel.text ?? "") else { return }
        if counter == 0  {
            return
        }
        counter -= 1
        countLabel.text = "\(counter)"
    }
    @IBAction func restCounter(_ sender: UIButton) {
        countLabel.text = "33"
    }
    //MARK:-Methods
    func customizeBtn(selectedBtn:UIButton , firstBtn:UIButton , secondBtn:UIButton) {
        selectedBtn.setTitleColor(#colorLiteral(red: 0.2745098039, green: 0.5294117647, blue: 0.7568627451, alpha: 1), for: .normal)
        selectedBtn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        selectedBtn.layer.borderWidth = 1
        selectedBtn.layer.borderColor = #colorLiteral(red: 0.2745098039, green: 0.5294117647, blue: 0.7568627451, alpha: 1)
        firstBtn.setTitleColor( #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) , for: .normal)
        firstBtn.backgroundColor = #colorLiteral(red: 0.2745098039, green: 0.5294117647, blue: 0.7568627451, alpha: 1)
        firstBtn.layer.borderColor = UIColor.clear.cgColor
        secondBtn.setTitleColor( #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) , for: .normal)
        secondBtn.backgroundColor = #colorLiteral(red: 0.2745098039, green: 0.5294117647, blue: 0.7568627451, alpha: 1)
        secondBtn.layer.borderColor = UIColor.clear.cgColor
    }
    func customizeButton(selectedBtn:UIButton , firstBtn:UIButton , secondBtn:UIButton , third : UIButton) {
        selectedBtn.backgroundColor = .white
        selectedBtn.cornerRadius = 10
        firstBtn.backgroundColor = .clear
        secondBtn.backgroundColor = .clear
        third.backgroundColor = .clear
    }
    
}
