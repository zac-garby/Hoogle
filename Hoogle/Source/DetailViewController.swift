//
//  DetailViewController.swift
//  Hoogle
//
//  Created by Zac Garby on 28/04/2019.
//  Copyright © 2019 Zac Garby. All rights reserved.
//

import Cocoa
import WebKit
import SwiftSoup

class DetailViewController: NSViewController, WKUIDelegate {
    @IBOutlet var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func show(_ result: Result) throws {
        let doc = try SwiftSoup.parse(
              "<html>"
            + "<head>"
            +   "<style>"
            +     "html { font-family: sans-serif; padding: 20px; word-wrap: break-word; }"
            +     "h1, h2, h3 { margin-top: 5px; margin-bottom: 5px; font-weight: normal; }"
            +     "#item { font-family: Menlo; }"
            +     "#module, #package { color: rgb(128, 128, 128); }"
            +     "s0 { color: #8e0f55; font-weight: bold; }"
            +   "</style>"
            + "</head>"
            + "<body>"
            +   "<h2 id=item></h2>"
            +   "<h3 id=module></h3>"
            +   "<h3 id=package></h3>"
            +   "<p id=docs></p>"
            + "</body>"
            + "</html>")
        
        try doc.select("#item").first()!.html(result.item)
        
        // Annoying thing because for some reason SwiftSoup inserts newlines around s0 elements.
        // This fixes it by replacing <s0> with <span class="s0">
        try doc.select("s0").forEach { el in
            try el.tagName("span")
            try el.addClass("s0")
        }
        
        try doc.select("#docs").first()!.html(result.docs)
        
        if let module = result.module {
            try doc.select("#module").first()!.text(module)
        }
        
        if let package = result.package {
            try doc.select("#package").first()!.text(package)
        }
        
        webView.loadHTMLString(doc.description, baseURL: nil)
    }
}
