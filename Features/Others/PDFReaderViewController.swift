//
//  PDFReaderViewController.swift
//  Judgement
//
//  Created by Oliver Hauth on 05.01.18.
//  Copyright © 2018 nogoodname. All rights reserved.
//

import UIKit
import WebKit

class PDFReaderViewController: UIViewController, WKNavigationDelegate {
    @IBOutlet weak var webView: WKWebView!
    
    private var _pdfName: String = ""
    var pdfName: String {
        get { return self._pdfName }
        set {
            self._pdfName = newValue
            if let documentURL = Bundle.main.url(forResource: newValue, withExtension: ".pdf") {
                let urlRequest = URLRequest(url: documentURL)
                if let webView = self.webView {
                    webView.load(urlRequest)
                }
            }
        }
    }
    
    var scrollPositionKey : ScrollPosition = .rulebookScrollPosition
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self
        
        self.title = "Rulebook"
        
        if self._pdfName != "" {
            if let documentURL = Bundle.main.url(forResource: self._pdfName, withExtension: ".pdf") {
                let urlRequest = URLRequest(url: documentURL)
                if let webView = self.webView {
                    webView.load(urlRequest)
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        TempSettings.sharedInstance[self.scrollPositionKey] = Int(self.webView.scrollView.contentOffset.y)
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.scrollView.contentOffset = CGPoint(x: 0, y: TempSettings.sharedInstance[self.scrollPositionKey]!)
    }
}
