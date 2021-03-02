//  PDFViewController.swift
//  PDFReader
//
//  Created by ALUA KINZHEBAYEVA on 4/19/15.
//  Copyright (c) 2015 AK. All rights reserved.
//

import UIKit

var soraArr = ["الفاتحة" , "البقرة" , "آل عمران" , "النساء" , "المائدة" , "الأنعام" , "الأعراف" , "الأنفال" , "التوبة" , "يونس" , "هود" , "يوسف" , "الرعد" , "ابراهيم" , "الحجر" , "النحل" , "الإسراء" , "الكهف" , "مريم" , "طه" , "الأنبياء" , "الحج" , "المؤمنون" , "النور" , "الفرقان" , "الشعراء" , "النمل" , "القصص" , "العنكبوت" , "الروم" , "لقمان" , "السجدة" , "الأحزاب" , "سبأ" , "فاطر" , "يس" , "الصافات" , "ص" , "الزمر" , "غافر" , "فصلت" , "الشورى" , "الزخرف" , "الدخان" , "الجاثية" , "الأحقاف" , "محمد" , "الفتح" , "الحجرات" , "ق" , "الذاريات" , "الطور" , "النجم" , "القمر" , "الرحمن" , "الواقعة" , "الحديد" , "المجادلة" , "الحشر" , "الممتحنة" , "الصف"    , "الجمعة" , "المنافقون" , "التغابن" , "الطلاق" , "التحريم" , "الملك" , "القلم" , "الحاقة" , "المعارج" , "نوح" , "الجن" , "المزمل" , "المدثر" , "القيامة" , "الإنسان" , "المرسلات" , "النبأ" , "النازعات" , "عبس" , "التكوير"   , "الإنفطار" , "المطففين" , "الانشقاق" , "البروج" , "الطارق" , "الأعلى" , "الغاشية" , "الفجر" , "البلد" , "الشمس" , "الليل" , "الضحى" , "الشرح" , "التين" , "العلق" , "القدر" , "البينة"    , "الزلزلة" , "العاديات" , "القارعة" , "التكاثر" , "العصر" , "الهمزة" , "الفيل" , "قريش" , "الماعون" , "الكوثر" , "الكافرون" , "النصر" , "المسد" , "الإخلاص" , "الفلق" , "الناس" ]
enum SewarQuran {
    case fatha
    case elbakra
    case alOmran
    case elnesaa
    case elMaada
    case elanaam
    case elaraaf
    case elanfal
    case eltawba
    case yones
    case hod
    case yousf
    case raad
    case ibrahim
    case elhagr
    case elnahl
    case elasraa
    case elkahf
    case mariam
    case taha
    case elanbyaa
    case elhag
    case elmoamenon
    case elnoor
    case elforkan
    case elshoaraa
    case elnaml
    case elkesas
    case elankaboot
    case elroom
    case lokman
    case elsagda
    case elahzab
    case sabaa
    case fater
    case yassen
    case elsafaat
    case sad
    case elzomor
    case ghafer
    case faslt
    case elshora
    case elzakhraf
    case eldokhan
    case elgathya
    case elahkak
    case mohamed
    case elfath
    case elhagrat
    case kaf
    case elzoreyat
    case eltor
    case elnegm
    case elkamr
    case elwakaa
    case elhaded
    case elmogadala
    case elhashr
    case elmomtahena
    case elsaf
    case elgomaa
    case elmonafekon
    case eltaghabon
    case eltalaa
    case eltahreem
    case elmolk
    case elalam
    case elhaka
    case elmearag
    case nooh
    case elgen
    case elmozmel
    case elmodaser
    case elkeyama
    case elensan
    case elmorslat
    case elnabaa
    case elnezaat
    case elabs
    case eltakwer
    case elanfetar
    case elmotafafen
    case elenshekak
    case elberog
    case eltareq
    case elaala
    case elgasheya
    case elfagr
    case elbalad
    case elshams
    case elleil
    case eldoha
    case elsharh
    case elteen
    case elalak
    case elkadr
    case elbayena
    case elzalzala
    case eladeyat
    case elkareaa
    case eltaksor
    case elosr
    case elhamza
    case elfeel
    case koresh
    case elmaoon
    case elkosar
    case elkaferon
    case elnasr
    case elmasd
    case elakhlas
    case elfalaq
    case elnas
}
@available(iOS 9.0, *)
extension PDFViewController {
    /// Initializes a new `PDFViewController`
    ///
    /// - parameter document:            PDF document to be displayed
    /// - parameter title:               title that displays on the navigation bar on the PDFViewController; 
    ///                                  if nil, uses document's filename
    /// - parameter actionButtonImage:   image of the action button; if nil, uses the default action system item image
    /// - parameter actionStyle:         sytle of the action button
    /// - parameter backButton:          button to override the default controller back button
    /// - parameter isThumbnailsEnabled: whether or not the thumbnails bar should be enabled
    /// - parameter startPageIndex:      page index to start on load, defaults to 0; if out of bounds, set to 0
    ///
    /// - returns: a `PDFViewController`
    public class func createNew(with document: PDFDocument, title: String? = nil, actionButtonImage: UIImage? = nil, actionStyle: ActionStyle = .print, backButton: UIBarButtonItem? = nil, isThumbnailsEnabled: Bool = true, startPageIndex: Int = 0) -> PDFViewController {
        let storyboard = UIStoryboard(name: "PDFReader", bundle: Bundle(for: PDFViewController.self))
        let controller = storyboard.instantiateInitialViewController() as! PDFViewController
        controller.document = document
        controller.actionStyle = actionStyle
        
        if let title = title {
            controller.title = title
        } else {
            controller.title = "القرآن الكريم"
        }
        
        if startPageIndex >= 0 && startPageIndex < document.pageCount {
            controller.currentPageIndex = startPageIndex
        } else {
            controller.currentPageIndex = 0
        }
//        controller.backButton = backButton
//        if let actionButtonImage = actionButtonImage {
//            controller.actionButton = UIBarButtonItem(image: actionButtonImage, style: .plain, target: controller, action: #selector(actionButtonPressed))
//        } else {
//            controller.actionButton = UIBarButtonItem(barButtonSystemItem: .action, target: controller, action: #selector(actionButtonPressed))
//        }
        controller.isThumbnailsEnabled = isThumbnailsEnabled
        return controller
    }
}


/// Controller that is able to interact and navigate through pages of a `PDFDocument`
@available(iOS 9.0, *)
public  class PDFViewController: UIViewController {
    /// Action button style
    public enum ActionStyle {
        /// Brings up a print modal allowing user to print current PDF
        case print
        
        /// Brings up an activity sheet to share or open PDF in another app
        case activitySheet
        
        /// Performs a custom action
        case customAction(() -> ())
    }
    
    /// Collection veiw where all the pdf pages are rendered
    @IBOutlet public var collectionView: UICollectionView!
    @IBOutlet weak var quranView: UIView!
    @IBOutlet weak var quranImageView: UIImageView!
    
    @IBOutlet public var fahresTableView: UITableView! {
        didSet {
            fahresTableView.dataSource = self
            fahresTableView.delegate = self
        }
    }
    
    /// Height of the thumbnail bar (used to hide/show)
    @IBOutlet private var thumbnailCollectionControllerHeight: NSLayoutConstraint!
    
    /// Distance between the bottom thumbnail bar with bottom of page (used to hide/show)
    @IBOutlet private var thumbnailCollectionControllerBottom: NSLayoutConstraint!
    
    /// Width of the thumbnail bar (used to resize on rotation events)
    @IBOutlet private var thumbnailCollectionControllerWidth: NSLayoutConstraint!
    
    /// PDF document that should be displayed
    private var document: PDFDocument!
    
    private var actionStyle = ActionStyle.print
    
    /// Image used to override the default action button image
    private var actionButtonImage: UIImage?
    
    /// Current page being displayed
    private var currentPageIndex: Int = 0
    
    /// Bottom thumbnail controller
    private var thumbnailCollectionController: PDFThumbnailCollectionViewController?
    
    /// UIBarButtonItem used to override the default action button
    private var actionButton: UIBarButtonItem?
    
    /// Backbutton used to override the default back button
    private var backButton: UIBarButtonItem?
    
    /// Background color to apply to the collectionView.
    public var backgroundColor: UIColor? = .lightGray {
        didSet {
            collectionView?.backgroundColor = backgroundColor
        }
    }
    
    /// Whether or not the thumbnails bar should be enabled
    private var isThumbnailsEnabled = true {
        didSet {
            if thumbnailCollectionControllerHeight == nil {
                _ = view
            }
            if !isThumbnailsEnabled {
                thumbnailCollectionControllerHeight.constant = 0
            }
        }
    }
    
    /// Slides horizontally (from left to right, default) or vertically (from top to bottom)
    public var scrollDirection: UICollectionView.ScrollDirection = .horizontal {
        didSet {
            if collectionView == nil {  // if the user of the controller is trying to change the scrollDiecton before it
                _ = view                // is on the sceen, we need to show it ofscreen to access it's collectionView.
            }
            if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.scrollDirection = scrollDirection
            }
        }
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        Swift.print("dsdsdsdsdsds\(soraArr.count)")
        quranImageView.image = #imageLiteral(resourceName: "QuranIcon")
        UIView.appearance().semanticContentAttribute = .forceRightToLeft
        collectionView.backgroundColor = .white
        collectionView.register(PDFPageCollectionViewCell.self, forCellWithReuseIdentifier: "page")
        
//        navigationItem.rightBarButtonItem = actionButton
//        if let backItem = backButton {
//            navigationItem.leftBarButtonItem = backItem
//        }
//
        let numberOfPages = CGFloat(document.pageCount)
        let cellSpacing = CGFloat(2.0)
        let totalSpacing = (numberOfPages - 1.0) * cellSpacing
        let thumbnailWidth = (numberOfPages * PDFThumbnailCell.cellSize.width) + totalSpacing
        let width = min(thumbnailWidth, view.bounds.width)
        thumbnailCollectionControllerWidth.constant = width
    }
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIView.appearance().semanticContentAttribute = .forceLeftToRight
    }

    @IBAction func dismissView(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true , completion: nil)
    }
    @IBAction func fahresClicked(_ sender: UIBarButtonItem) {
        self.fahresTableView.isHidden = !self.fahresTableView.isHidden
    }
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        goToSora(row: 0)
        quranImageView.image = #imageLiteral(resourceName: "QuranIcon")
        let delayTime = DispatchTime.now() + 1.0
        DispatchQueue.main.asyncAfter(deadline: delayTime, execute: {
            self.quranView.isHidden = true
        })
    }
    func goToSora(row:Int) {
        self.collectionView.scrollToItem(at: IndexPath(row: row, section: 0) , at: .left , animated: true)
        self.fahresTableView.isHidden = true
        self.collectionView.reloadData()
    }
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        didSelectIndexPath(IndexPath(row: currentPageIndex, section: 0))
    }
    
    override public var prefersStatusBarHidden: Bool {
        return navigationController?.isNavigationBarHidden == true
    }
    
    override public var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
    
    public override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return isThumbnailsEnabled
    }
    
    override public func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? PDFThumbnailCollectionViewController {
            thumbnailCollectionController = controller
            controller.document = document
            controller.delegate = self
            controller.currentPageIndex = currentPageIndex
        }
    }
    
    public override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { context in
            let currentIndexPath = IndexPath(row: self.currentPageIndex, section: 0)
            self.collectionView.reloadItems(at: [currentIndexPath])
            self.collectionView.scrollToItem(at: currentIndexPath, at: .centeredHorizontally, animated: false)
            }) { context in
                self.thumbnailCollectionController?.currentPageIndex = self.currentPageIndex
        }
        
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    /// Takes an appropriate action based on the current action style
    @objc func actionButtonPressed() {
        switch actionStyle {
        case .print:
            print()
        case .activitySheet:
            presentActivitySheet()
        case .customAction(let customAction):
            customAction()
        }
    }
    
    /// Presents activity sheet to share or open PDF in another app
    private func presentActivitySheet() {
        let controller = UIActivityViewController(activityItems: [document.fileData], applicationActivities: nil)
        controller.popoverPresentationController?.barButtonItem = actionButton
        present(controller, animated: true, completion: nil)
    }
    
    /// Presents print sheet to print PDF
    private func print() {
        guard UIPrintInteractionController.isPrintingAvailable else { return }
        guard UIPrintInteractionController.canPrint(document.fileData) else { return }
        guard document.password == nil else { return }
        let printInfo = UIPrintInfo.printInfo()
        printInfo.duplex = .longEdge
        printInfo.outputType = .general
        printInfo.jobName = document.fileName
        
        let printInteraction = UIPrintInteractionController.shared
        printInteraction.printInfo = printInfo
        printInteraction.printingItem = document.fileData
        printInteraction.showsPageRange = true
        printInteraction.present(animated: true, completionHandler: nil)
    }
}

@available(iOS 9.0, *)
extension PDFViewController: PDFThumbnailControllerDelegate {
    func didSelectIndexPath(_ indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
        thumbnailCollectionController?.currentPageIndex = currentPageIndex
    }
}

@available(iOS 9.0, *)
extension PDFViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return document.pageCount
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "page", for: indexPath) as! PDFPageCollectionViewCell
        cell.setup(indexPath.row, collectionViewBounds: collectionView.bounds, document: document, pageCollectionViewCellDelegate: self)
        return cell
    }
}

@available(iOS 9.0, *)
extension PDFViewController: PDFPageCollectionViewCellDelegate {
    /// Toggles the hiding/showing of the thumbnail controller
    ///
    /// - parameter shouldHide: whether or not the controller should hide the thumbnail controller
    private func hideThumbnailController(_ shouldHide: Bool) {
        self.thumbnailCollectionControllerBottom.constant = shouldHide ? -thumbnailCollectionControllerHeight.constant : 0
    }
    
    func handleSingleTap(_ cell: PDFPageCollectionViewCell, pdfPageView: PDFPageView) {
        var shouldHide: Bool {
            guard let isNavigationBarHidden = navigationController?.isNavigationBarHidden else {
                return false
            }
            return !isNavigationBarHidden
        }
        UIView.animate(withDuration: 0.25) {
            self.hideThumbnailController(shouldHide)
            self.navigationController?.setNavigationBarHidden(shouldHide, animated: true)
        }
    }
}

@available(iOS 9.0, *)
extension PDFViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 1, height: collectionView.frame.height)
    }
}

@available(iOS 9.0, *)
extension PDFViewController: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let updatedPageIndex: Int
        if self.scrollDirection == .vertical {
            updatedPageIndex = Int(round(max(scrollView.contentOffset.y, 0) / scrollView.bounds.height))
        } else {
            updatedPageIndex = Int(round(max(scrollView.contentOffset.x, 0) / scrollView.bounds.width))
        }
        
        if updatedPageIndex != currentPageIndex {
            currentPageIndex = updatedPageIndex
            thumbnailCollectionController?.currentPageIndex = currentPageIndex
        }
    }
}

@available(iOS 9.0, *)
extension PDFViewController: UITableViewDataSource , UITableViewDelegate {
   

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return soraArr.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : fahresTableViewCell = tableView.dequeueReusableCell(withIdentifier: "fahresTableViewCell" , for: indexPath) as! fahresTableViewCell
        cell.fahresLabel.text = soraArr[indexPath.row]
        return cell
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.goToSora(row: 0)
            break
        case 1:
            self.goToSora(row: 1)
            break
        case 2:
            self.goToSora(row: 44)
            break
        case 3:
            self.goToSora(row: 68)
            break
        case 4:
            self.goToSora(row: 94)
            break
        case 5:
            self.goToSora(row: 114)
            break
        case 6:
            self.goToSora(row: 135)
            break
        case 7:
            self.goToSora(row: 159)
            break
        case 8:
            self.goToSora(row: 168)
            break
        case 9:
            self.goToSora(row: 186)
            break
        case 10:
            self.goToSora(row: 198)
            break
        case 11:
            self.goToSora(row: 212)
            break
        case 12:
            self.goToSora(row: 224)
            break
        case 13:
            self.goToSora(row: 230)
            break
        case 14:
            self.goToSora(row: 236)
            break
        case 15:
            self.goToSora(row: 241)
            break
        case 16:
            self.goToSora(row: 254)
            break
        case 17:
            self.goToSora(row: 265)
            break
        case 18:
            self.goToSora(row: 276)
            break
        case 19:
            self.goToSora(row: 283)
            break
        case 20:
            self.goToSora(row: 293)
            break
        case 21:
            self.goToSora(row: 302)
            break
        case 22:
            self.goToSora(row: 310)
            break
        case 23:
            self.goToSora(row: 318)
            break
        case 24:
            self.goToSora(row: 328)
            break
        case 25:
            self.goToSora(row: 334)
            break
        case 26:
            self.goToSora(row: 344)
            break
        case 27:
            self.goToSora(row: 353)
            break
        case 28:
            self.goToSora(row: 364)
            break
        case 29:
            self.goToSora(row: 370)
            break
        case 30:
            self.goToSora(row: 376)
            break
        case 31:
            self.goToSora(row: 380)
            break
        case 32:
            self.goToSora(row: 382)
            break
        case 33:
            self.goToSora(row: 392)
            break
        case 34:
            self.goToSora(row: 398)
            break
        case 35:
            self.goToSora(row: 403)
            break
        case 36:
            self.goToSora(row: 409)
            break
        case 37:
            self.goToSora(row: 416)
            break
        case 38:
            self.goToSora(row: 421)
            break
        case 39:
            self.goToSora(row: 430)
            break
        case 40:
            self.goToSora(row: 438)
            break
        case 41:
            self.goToSora(row: 444)
            break
        case 42:
            self.goToSora(row: 450)
            break
        case 43:
            self.goToSora(row: 456)
            break
        case 44:
            self.goToSora(row: 459)
            break
        case 45:
            self.goToSora(row: 463)
            break
        case 46:
            self.goToSora(row: 467)
            break
        case 47:
            self.goToSora(row: 471)
            break
        case 48:
            self.goToSora(row: 476)
            break
        case 49:
            self.goToSora(row: 478)
            break
        case 50:
            self.goToSora(row: 481)
            break
        case 51:
            self.goToSora(row: 484)
            break
        case 52:
            self.goToSora(row: 486)
            break
        case 53:
            self.goToSora(row: 489)
            break
        case 54:
            self.goToSora(row: 492)
            break
        case 55:
            self.goToSora(row: 495)
            break
        case 56:
            self.goToSora(row: 498)
            break
        case 57:
            self.goToSora(row: 503)
            break
        case 58:
            self.goToSora(row: 506)
            break
        case 59:
            self.goToSora(row: 509)
            break
        case 60:
            self.goToSora(row: 512)
            break
        case 61:
            self.goToSora(row: 514)
            break
        case 62:
            self.goToSora(row: 515)
            break
        case 63:
            self.goToSora(row: 517)
            break
        case 64:
            self.goToSora(row: 519)
            break
        case 65:
            self.goToSora(row: 521)
            break
        case 66:
            self.goToSora(row: 523)
            break
        case 67:
            self.goToSora(row: 525)
            break
        case 68:
            self.goToSora(row: 528)
            break
        case 69:
            self.goToSora(row: 530)
            break
        case 70:
            self.goToSora(row: 532)
            break
        case 71:
            self.goToSora(row: 533)
            break
        case 72:
            self.goToSora(row: 536)
            break
        case 73:
            self.goToSora(row: 537)
            break
        case 74:
            self.goToSora(row: 539)
            break
        case 75:
            self.goToSora(row: 541)
            break
        case 76:
            self.goToSora(row: 543)
            break
        case 77:
            self.goToSora(row: 544)
            break
        case 78:
            self.goToSora(row: 546)
            break
        case 79:
            self.goToSora(row: 547)
            break
        case 80:
            self.goToSora(row: 549)
            break
        case 81:
            self.goToSora(row: 550)
            break
        case 82:
            self.goToSora(row: 551)
            break
        case 83:
            self.goToSora(row: 552)
            break
        case 84:
            self.goToSora(row: 553)
            break
        case 85:
            self.goToSora(row: 554)
            break
        case 86:
            self.goToSora(row: 555)
            break
        case 87:
            self.goToSora(row: 555)
            break
        case 88:
            self.goToSora(row: 556)
            break
        case 89:
            self.goToSora(row: 558)
            break
        case 90:
            self.goToSora(row: 558)
            break
        case 91:
            self.goToSora(row: 559)
            break
        case 92:
            self.goToSora(row: 560)
            break
        case 93:
            self.goToSora(row: 560)
            break
        case 94:
            self.goToSora(row: 561)
            break
        case 95:
            self.goToSora(row: 561)
            break
        case 96:
            self.goToSora(row: 562)
            break
        case 97:
            self.goToSora(row: 562)
            break
        case 98:
            self.goToSora(row: 563)
            break
        case 99:
            self.goToSora(row: 563)
            break
        case 100:
            self.goToSora(row: 564)
            break
        case 101:
            self.goToSora(row: 564)
            break
        case 102:
            self.goToSora(row: 565)
            break
        case 103:
            self.goToSora(row: 565)
            break
        case 104:
            self.goToSora(row: 565)
            break
        case 105:
            self.goToSora(row: 566)
            break
        case 106:
            self.goToSora(row: 566)
            break
        case 107:
            self.goToSora(row: 566)
            break
        case 108:
            self.goToSora(row: 567)
            break
        case 109:
            self.goToSora(row: 567)
            break
        case 110:
            self.goToSora(row: 567)
            break
        case 111:
            self.goToSora(row: 568)
            break
        case 112:
            self.goToSora(row: 568)
            break
        case 113:
            self.goToSora(row: 568)
            break

        default:
            break
        }
       
    }
}


class fahresTableViewCell: UITableViewCell {
    @IBOutlet weak var fahresLabel: UILabel!
}
