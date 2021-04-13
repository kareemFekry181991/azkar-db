//
//  QuraanKareemViewController.swift
//  Azkar
//
//  Created by Kareem on 2/28/21.
//  Copyright © 2021 Kareem. All rights reserved.
//

import UIKit
import PDFKit


class QuraanKareemViewController: UIViewController {
    
    @IBOutlet weak var viewForPdf: UIView!
    var pdfView = PDFView()

    @IBOutlet weak var settingsView: UIView!
    @IBOutlet weak var addMarkImage: UIImageView!
    private var pdfDocument: PDFDocument?
    weak var delegate : GoToQuranPageDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewForPdf.backgroundColor = .white
        self.view.backgroundColor = .white
        pdfView.delegate = self
        pdfView = PDFView(frame: self.view.bounds)
        pdfView.pageBreakMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        pdfView.autoScales = true
        pdfView.displayDirection = .horizontal
        pdfView.usePageViewController(true, withViewOptions: [UIPageViewController.OptionsKey.interPageSpacing: 10])
        pdfView.displaysAsBook = true
        pdfView.backgroundColor = UIColor.white
        pdfView.backgroundColor = UIColor.white
        pdfView.displayMode = .singlePage
        pdfView.displaysRTL = true
        pdfView.translatesAutoresizingMaskIntoConstraints = false

        self.viewForPdf.addSubview(pdfView)
        pdfView.leadingAnchor.constraint(equalTo: viewForPdf.safeAreaLayoutGuide.leadingAnchor).isActive = true
        pdfView.trailingAnchor.constraint(equalTo: viewForPdf.safeAreaLayoutGuide.trailingAnchor).isActive = true
        pdfView.topAnchor.constraint(equalTo: viewForPdf.safeAreaLayoutGuide.topAnchor).isActive = true
        pdfView.bottomAnchor.constraint(equalTo: viewForPdf.safeAreaLayoutGuide.bottomAnchor).isActive = true

        guard let path = Bundle.main.url(forResource: "quran_new", withExtension: "pdf") else {
            return
        }
        pdfDocument = PDFDocument(url: path)
        pdfView.document = pdfDocument
        pdfView.pageShadowsEnabled = false
        pdfView.displayMode = .singlePage
        pdfView.autoScales = true
        pdfView.frame.size.height = pdfView.documentView?.frame.height ?? self.view.frame.height
        self.view.layoutIfNeeded()
        pdfView.minScaleFactor = pdfView.scaleFactorForSizeToFit
        viewForPdf.UIViewAction {
            print("uuuuu")
        }
        pdfView.UIViewAction {
            print("hhh")
            self.settingsView.isHidden =  !self.settingsView.isHidden
        }

        if UserStatus.quranPage != nil {
            goToSora(row: UserStatus.quranPage ?? 0)
        }
        NotificationCenter.default.addObserver (self, selector: #selector(handlePageChange), name: Notification.Name.PDFViewPageChanged, object: nil)

    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let pageNumber = self.pdfDocument?.index(for: self.pdfView.currentPage ??  PDFPage()) ?? 0
        UserStatus.quranPage = pageNumber
        print("QuraaaanPageeeeeeee\(pageNumber)")
        NotificationCenter.default.removeObserver (self , name: Notification.Name.PDFViewPageChanged, object: nil)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver (self, selector: #selector(handlePageChange), name: Notification.Name.PDFViewPageChanged, object: nil)
        let pageNumber = self.pdfDocument?.index(for: self.pdfView.currentPage ??  PDFPage()) ?? 0
        if UserStatus.markedQuranPage == pageNumber {
            self.addMarkImage.isHidden = false
        } else {
            self.addMarkImage.isHidden = true
        }
        HelperMethods.reverseNavColor(nav: self.navigationController ?? UINavigationController())
    }
    func goToSora(row:Int) {
        UserStatus.quranPage = row
        guard let page = pdfDocument?.page(at:row) else { return }
        self.pdfView.go(to: page)
        let pageNumber = self.pdfDocument?.index(for: self.pdfView.currentPage ??  PDFPage()) ?? 0
        if UserStatus.markedQuranPage == pageNumber {
            self.addMarkImage.isHidden = false
        } else {
            self.addMarkImage.isHidden = true
        }
    }
    
    @IBAction func fahresClicked(_ sender: UIBarButtonItem) {
        let fahresViewController = self.storyboard?.instantiateViewController(identifier: "FahresViewController") as! FahresViewController
        fahresViewController.delegate = self
        self.navigationController?.pushViewController(fahresViewController , animated: true)
    }
    
    @IBAction func dismissClicked(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveMarkClicked(_ sender: UIButton) {
        let pageNumber = self.pdfDocument?.index(for: self.pdfView.currentPage ??  PDFPage()) ?? 0
        if  UserStatus.markedQuranPage == pageNumber {
            UserStatus.markedQuranPage = nil
            addMarkImage.isHidden = true

        } else {
            UserStatus.markedQuranPage = pageNumber
            addMarkImage.isHidden = false
        }
        
    }
    @IBAction func movetoMarkClicked(_ sender: UIButton) {
        if UserStatus.markedQuranPage != nil {
            goToSora(row: UserStatus.markedQuranPage ?? 0)
//            addMarkImage.isHidden = false
            let pageNumber = self.pdfDocument?.index(for: self.pdfView.currentPage ??  PDFPage()) ?? 0
            if UserStatus.markedQuranPage == pageNumber {
                self.addMarkImage.isHidden = false
            } else {
                self.addMarkImage.isHidden = true
            }
        }
    }
    @IBAction func goToFahresClicked(_ sender: UIButton) {
        let fahresViewController = self.storyboard?.instantiateViewController(identifier: "FahresViewController") as! FahresViewController
        fahresViewController.delegate = self
        self.navigationController?.pushViewController(fahresViewController , animated: true)
    }
    @IBAction func goToAgzaaClicked(_ sender: UIButton) {
    }
}
extension QuraanKareemViewController : GoToQuranPageDelegate {
    func gotPage(page: Int) {
        goToSora(row: page)
        
    }
}

extension QuraanKareemViewController : PDFViewDelegate {
    @objc func handlePageChange() {
        let pageNumber = self.pdfDocument?.index(for: self.pdfView.currentPage ??  PDFPage()) ?? 0
        if UserStatus.markedQuranPage == pageNumber {
            self.addMarkImage.isHidden = false
        } else {
            self.addMarkImage.isHidden = true
        }
    }
}
extension QuraanKareemViewController  :  UIScrollViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let pageNumber = self.pdfDocument?.index(for: self.pdfView.currentPage ??  PDFPage()) ?? 0
        if UserStatus.markedQuranPage == pageNumber {
            self.addMarkImage.isHidden = false
        } else {
            self.addMarkImage.isHidden = true
        }
    }
}
