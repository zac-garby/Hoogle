//
//  DetailViewController.swift
//  Hoogle
//
//  Created by Zac Garby on 28/04/2019.
//  Copyright © 2019 Zac Garby. All rights reserved.
//

import Cocoa
import WebKit

class DetailViewController: NSViewController, WKUIDelegate {
    @IBOutlet var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // webView.loadHTMLString("", baseURL: nil)
    }
}

