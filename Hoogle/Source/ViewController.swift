//
//  ViewController.swift
//  Hoogle
//
//  Created by Zac Garby on 01/05/2019.
//  Copyright © 2019 Zac Garby. All rights reserved.
//

import Cocoa
import Alamofire
import SwiftSoup

class ViewController: NSSplitViewController {
    var results: [Result] = []
    
    var sidebar: SidebarViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sidebar = splitViewItems[0].viewController as? SidebarViewController
        
        updateData()
    }
    
    func updateData() {
        sidebar.results = results
        sidebar.updateData()
    }
    
    func select(index: Int) {
        print("Selected \(index)")
    }
    
    func search(for searchTerm: String) {
        if searchTerm == "" {
            return
        }
        
        let params: Parameters = [
            "mode": "json",
            "hoogle": searchTerm,
        ]
        
        AF.request("https://hoogle.haskell.org", parameters: params).responseJSON { response in
            guard let data = response.value as? [[String:Any]] else {
                print("Invalid data!")
                return
            }
            
            self.results = []
            
            for result in data {
                guard let url = result["url"] as? String else { return }
                guard let module = result["module"] as? [String:String] else { return }
                guard let package = result["package"] as? [String:String] else { return }
                guard let item = result["item"] as? String else { return }
                guard let type = result["type"] as? String else { return }
                guard let docs = result["docs"] as? String else { return }
                
                let moduleName = module["name"] ?? nil
                let moduleUrl = module["url"] ?? nil
                let packageName = package["name"] ?? nil
                let packageUrl = package["url"] ?? nil
                
                // Wow, this is pretty terrible. Is there a better way to do it?
                var kind = ResultKind.function
                switch type {
                case "module":
                    kind = .module
                case "package":
                    kind = .package
                default:
                    if item.starts(with: "<b>data") ||
                        item.starts(with: "<b>type") ||
                        item.starts(with: "<b>type family") ||
                        item.starts(with: "<b>newtype") ||
                        item.starts(with: "<b>class") {
                        kind = .type
                    }
                }
                
                do {
                    let itemHtml = try SwiftSoup.parse(item)
                    let itemText = try itemHtml.text()
                    
                    self.results.append(Result(url: url,
                                               kind: kind,
                                               item: itemText,
                                               docs: docs,
                                               module: moduleName,
                                               moduleUrl: moduleUrl,
                                               package: packageName,
                                               packageUrl: packageUrl))
                    
                } catch {
                    print("Couldn't parse HTML data: \(item)")
                }
            }
            
            self.updateData()
        }
    }
}
