//
//  ViewController.swift
//  WebPage2PDF
//
//  Created by HongHao Zhang on 2017-07-20.
//  Copyright © 2017 Honghaoz. All rights reserved.
//

import Cocoa
import WebKit

class ViewController: NSViewController {

    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self
        webView.customUserAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_5) AppleWebKit/603.2.4 (KHTML, like Gecko) Version/10.1.1 Safari/603.2.4"
        
        let urlRequest = URLRequest(url: URL(string: "http://www.google.com/")!)
        webView.load(urlRequest)
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        var frame = self.view.window!.frame
        frame.size = CGSize(width: 1024, height: 768)
        self.view.window?.setFrame(frame, display: true)
        
        //self.view.window?.titleVisibility = .hidden
        //self.view.window?.titlebarAppearsTransparent = true
        //self.view.window?.styleMask.insert(.fullSizeContentView)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    fileprivate func savePDF() {
        let pdfData = webView.dataWithPDF(inside: webView.frame)
        
        let desktopPath = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask).first!
        let fileName = desktopPath.appendingPathComponent("WebPage2PDF.pdf")

        do {
            try pdfData.write(to: fileName, options: .atomic)
        } catch {
            // failed to write file – bad permissions, bad filename, missing permissions, or more likely it can't be converted to the encoding
        }
    }
}

extension ViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        savePDF()
    }
}
