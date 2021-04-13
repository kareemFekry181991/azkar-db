//
//  FahresViewController.swift
//  Azkar
//
//  Created by Kareem on 3/27/21.
//  Copyright © 2021 Kareem. All rights reserved.
//

import UIKit


protocol GoToQuranPageDelegate : class{
    func gotPage(page:Int)
}
struct Sora {
    var soraName = ""
    var soraPageNumber = ""
    init(soraName:String , soraPageNumber:String) {
        self.soraName = soraName
        self.soraPageNumber = soraPageNumber
    }
}
class FahresViewController: UIViewController {
    
    @IBOutlet weak var soraSearchTextField: UITextField!
    var fahresArr = [Sora]()
    var filterSora = [Sora]()
    var originalSoraArr = [Sora]()
    var soraArr = ["الفاتحة" , "البقرة" , "آل عمران" , "النساء" , "المائدة" , "الأنعام" , "الأعراف" , "الأنفال" , "التوبة" , "يونس" , "هود" , "يوسف" , "الرعد" , "ابراهيم" , "الحجر" , "النحل" , "الإسراء" , "الكهف" , "مريم" , "طه" , "الأنبياء" , "الحج" , "المؤمنون" , "النور" , "الفرقان" , "الشعراء" , "النمل" , "القصص" , "العنكبوت" , "الروم" , "لقمان" , "السجدة" , "الأحزاب" , "سبأ" , "فاطر" , "يس" , "الصافات" , "ص" , "الزمر" , "غافر" , "فصلت" , "الشورى" , "الزخرف" , "الدخان" , "الجاثية" , "الأحقاف" , "محمد" , "الفتح" , "الحجرات" , "ق" , "الذاريات" , "الطور" , "النجم" , "القمر" , "الرحمن" , "الواقعة" , "الحديد" , "المجادلة" , "الحشر" , "الممتحنة" , "الصف"    , "الجمعة" , "المنافقون" , "التغابن" , "الطلاق" , "التحريم" , "الملك" , "القلم" , "الحاقة" , "المعارج" , "نوح" , "الجن" , "المزمل" , "المدثر" , "القيامة" , "الإنسان" , "المرسلات" , "النبأ" , "النازعات" , "عبس" , "التكوير"   , "الإنفطار" , "المطففين" , "الانشقاق" , "البروج" , "الطارق" , "الأعلى" , "الغاشية" , "الفجر" , "البلد" , "الشمس" , "الليل" , "الضحى" , "الشرح" , "التين" , "العلق" , "القدر" , "البينة"    , "الزلزلة" , "العاديات" , "القارعة" , "التكاثر" , "العصر" , "الهمزة" , "الفيل" , "قريش" , "الماعون" , "الكوثر" , "الكافرون" , "النصر" , "المسد" , "الإخلاص" , "الفلق" , "الناس" ]
    
    
    var soraPageNumArr = ["1" , "2" , "45" , "69" , "95" , "115" , "136" , "160" , "169" , "187" , "199" , "213" , "225" , "231" , "237" ,
                          "242" , "255" , "266" , "277" , "284" , "294" , "303" , "311" , "319" , "329" , "335" , "345" , "354" , "365" , "371" , "377", "381" ,"383" , "393" , "399" , "404" , "410" , "417" , "422" , "431" , "439" , "445" , "451" , "457" , "460" , "464" , "468" , "472" , "477" , "479" , "482" , "485" , "487" , "490" , "493" , "496" , "499" , "504" , "507" , "510" , "513" , "515" , "516" , "518" , "520" , "522" , "524" , "526" , "529" , "531" , "533" , "534" , "537" , "538"  , "540" , "542" , "544" , "545" , "547" , "548" , "550" , "551" , "552" , "553" , "554" , "555" , "556" ,"556" , "557" , "559" , "559" , "560" , "561" , "561" , "562" , "562" , "563" , "563" , "564" , "564" , "565" , "565" , "566" , "566" , "566" , "567" ,"567" , "567" , "568" ,"568" , "568" , "569" , "569" , "569"]
    
    
    @IBOutlet public var fahresTableView: UITableView! {
        didSet {
            fahresTableView.dataSource = self
            fahresTableView.delegate = self
        }
    }
    weak var delegate : GoToQuranPageDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        for i in 0 ..< self.soraArr.count  {
            self.fahresArr.append(Sora(soraName: self.soraArr[i], soraPageNumber: self.soraPageNumArr[i]))
        }
        
        self.originalSoraArr = self.fahresArr

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        soraSearchTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField.text?.count ?? 0 > 1 {
            self.filterSora = self.fahresArr.filter {
                return $0.soraName.range(of: self.soraSearchTextField.text ?? "" , options: .caseInsensitive) != nil
            }
            self.fahresArr =  self.filterSora
        }
        if soraSearchTextField.text == "" {
            self.fahresArr = self.originalSoraArr
        }
        self.fahresTableView.reloadData()
    }

    func goToSora(row:Int) {
        self.delegate?.gotPage(page: row)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func dismissClicked(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func searchClicked(_ sender: UIBarButtonItem) {
        
        soraSearchTextField.isHidden = !soraSearchTextField.isHidden
        if soraSearchTextField.isHidden == true {
            self.title = "الفهرس"
        } else {
            
        }
    }
    
}


extension FahresViewController : UITableViewDataSource , UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fahresArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : fahresTableViewCell = tableView.dequeueReusableCell(withIdentifier: "fahresTableViewCell" , for: indexPath) as! fahresTableViewCell
        cell.fahresLabel.text = self.fahresArr[indexPath.row].soraName
        cell.indexnumberLabel.text = "\(indexPath.row + 1)"
        cell.pagenumberLabel.text = self.fahresArr[indexPath.row].soraPageNumber
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.goToSora(row: (Int(self.fahresArr[indexPath.row].soraPageNumber) ?? 0) - 1)
//        switch indexPath.row {
//        case 0:
//            self.goToSora(row: 0)
//            break
//        case 1:
//            self.goToSora(row: 1)
//            break
//        case 2:
//            self.goToSora(row: 44)
//            break
//        case 3:
//            self.goToSora(row: 68)
//            break
//        case 4:
//            self.goToSora(row: 94)
//            break
//        case 5:
//            self.goToSora(row: 114)
//            break
//        case 6:
//            self.goToSora(row: 135)
//            break
//        case 7:
//            self.goToSora(row: 159)
//            break
//        case 8:
//            self.goToSora(row: 168)
//            break
//        case 9:
//            self.goToSora(row: 186)
//            break
//        case 10:
//            self.goToSora(row: 198)
//            break
//        case 11:
//            self.goToSora(row: 212)
//            break
//        case 12:
//            self.goToSora(row: 224)
//            break
//        case 13:
//            self.goToSora(row: 230)
//            break
//        case 14:
//            self.goToSora(row: 236)
//            break
//        case 15:
//            self.goToSora(row: 241)
//            break
//        case 16:
//            self.goToSora(row: 254)
//            break
//        case 17:
//            self.goToSora(row: 265)
//            break
//        case 18:
//            self.goToSora(row: 276)
//            break
//        case 19:
//            self.goToSora(row: 283)
//            break
//        case 20:
//            self.goToSora(row: 293)
//            break
//        case 21:
//            self.goToSora(row: 302)
//            break
//        case 22:
//            self.goToSora(row: 310)
//            break
//        case 23:
//            self.goToSora(row: 318)
//            break
//        case 24:
//            self.goToSora(row: 328)
//            break
//        case 25:
//            self.goToSora(row: 334)
//            break
//        case 26:
//            self.goToSora(row: 344)
//            break
//        case 27:
//            self.goToSora(row: 353)
//            break
//        case 28:
//            self.goToSora(row: 364)
//            break
//        case 29:
//            self.goToSora(row: 370)
//            break
//        case 30:
//            self.goToSora(row: 376)
//            break
//        case 31:
//            self.goToSora(row: 380)
//            break
//        case 32:
//            self.goToSora(row: 382)
//            break
//        case 33:
//            self.goToSora(row: 392)
//            break
//        case 34:
//            self.goToSora(row: 398)
//            break
//        case 35:
//            self.goToSora(row: 403)
//            break
//        case 36:
//            self.goToSora(row: 409)
//            break
//        case 37:
//            self.goToSora(row: 416)
//            break
//        case 38:
//            self.goToSora(row: 421)
//            break
//        case 39:
//            self.goToSora(row: 430)
//            break
//        case 40:
//            self.goToSora(row: 438)
//            break
//        case 41:
//            self.goToSora(row: 444)
//            break
//        case 42:
//            self.goToSora(row: 450)
//            break
//        case 43:
//            self.goToSora(row: 456)
//            break
//        case 44:
//            self.goToSora(row: 459)
//            break
//        case 45:
//            self.goToSora(row: 463)
//            break
//        case 46:
//            self.goToSora(row: 467)
//            break
//        case 47:
//            self.goToSora(row: 471)
//            break
//        case 48:
//            self.goToSora(row: 476)
//            break
//        case 49:
//            self.goToSora(row: 478)
//            break
//        case 50:
//            self.goToSora(row: 481)
//            break
//        case 51:
//            self.goToSora(row: 484)
//            break
//        case 52:
//            self.goToSora(row: 486)
//            break
//        case 53:
//            self.goToSora(row: 489)
//            break
//        case 54:
//            self.goToSora(row: 492)
//            break
//        case 55:
//            self.goToSora(row: 495)
//            break
//        case 56:
//            self.goToSora(row: 498)
//            break
//        case 57:
//            self.goToSora(row: 503)
//            break
//        case 58:
//            self.goToSora(row: 506)
//
//            break
//        case 59:
//            self.goToSora(row: 509)
//            break
//        case 60:
//            self.goToSora(row: 512)
//            break
//        case 61:
//            self.goToSora(row: 514)
//            break
//        case 62:
//            self.goToSora(row: 515)
//            break
//        case 63:
//            self.goToSora(row: 517)
//            break
//        case 64:
//            self.goToSora(row: 519)
//
//            break
//        case 65:
//            self.goToSora(row: 521)
//            break
//        case 66:
//            self.goToSora(row: 523)
//            break
//        case 67:
//            self.goToSora(row: 525)
//            break
//        case 68:
//            self.goToSora(row: 528)
//            break
//        case 69:
//            self.goToSora(row: 530)
//            break
//        case 70:
//            self.goToSora(row: 532)
//            break
//        case 71:
//            self.goToSora(row: 533)
//            break
//        case 72:
//            self.goToSora(row: 536)
//            break
//        case 73:
//            self.goToSora(row: 537)
//            break
//        case 74:
//            self.goToSora(row: 539)
//            break
//        case 75:
//            self.goToSora(row: 541)
//            break
//        case 76:
//            self.goToSora(row: 543)
//            break
//        case 77:
//            self.goToSora(row: 544)
//            break
//        case 78:
//            self.goToSora(row: 546)
//            break
//        case 79:
//            self.goToSora(row: 547)
//            break
//        case 80:
//            self.goToSora(row: 549)
//            break
//        case 81:
//            self.goToSora(row: 550)
//            break
//        case 82:
//            self.goToSora(row: 551)
//            break
//        case 83:
//            self.goToSora(row: 552)
//            break
//        case 84:
//            self.goToSora(row: 553)
//            break
//        case 85:
//            self.goToSora(row: 554)
//            break
//        case 86:
//            self.goToSora(row: 555)
//            break
//        case 87:
//            self.goToSora(row: 555)
//            break
//        case 88:
//            self.goToSora(row: 556)
//            break
//        case 89:
//            self.goToSora(row: 558)
//            break
//        case 90:
//            self.goToSora(row: 558)
//            break
//        case 91:
//            self.goToSora(row: 559)
//            break
//        case 92:
//            self.goToSora(row: 560)
//
//            break
//        case 93:
//            self.goToSora(row: 560)
//            break
//        case 94:
//            self.goToSora(row: 561)
//            break
//        case 95:
//            self.goToSora(row: 561)
//            break
//        case 96:
//            self.goToSora(row: 562)
//            break
//        case 97:
//            self.goToSora(row: 562)
//            break
//        case 98:
//            self.goToSora(row: 563)
//            break
//        case 99:
//            self.goToSora(row: 563)
//            break
//        case 100:
//            self.goToSora(row: 564)
//            break
//        case 101:
//            self.goToSora(row: 564)
//            break
//        case 102:
//            self.goToSora(row: 565)
//            break
//        case 103:
//            self.goToSora(row: 565)
//            break
//        case 104:
//            self.goToSora(row: 565)
//            break
//        case 105:
//            self.goToSora(row: 566)
//            break
//        case 106:
//            self.goToSora(row: 566)
//            break
//        case 107:
//            self.goToSora(row: 566)
//            break
//        case 108:
//            self.goToSora(row: 567)
//            break
//        case 109:
//            self.goToSora(row: 567)
//            break
//        case 110:
//            self.goToSora(row: 567)
//            break
//        case 111:
//            self.goToSora(row: 568)
//            break
//        case 112:
//            self.goToSora(row: 568)
//            break
//        case 113:
//            self.goToSora(row: 568)
//            break
//
//        case <#pattern#>:
//        <#code#>
//default:
//            break
//        }
        
    }
}


class fahresTableViewCell: UITableViewCell {
    @IBOutlet weak var fahresLabel: UILabel!
    @IBOutlet weak var pagenumberLabel: UILabel!
    @IBOutlet weak var indexnumberLabel: UILabel!
}

