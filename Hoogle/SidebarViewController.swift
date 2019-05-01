//
//  SidebarViewController.swift
//  Hoogle
//
//  Created by Zac Garby on 29/04/2019.
//  Copyright © 2019 Zac Garby. All rights reserved.
//

import Cocoa

class SidebarViewController: NSViewController {
    @IBOutlet weak var resultsTable: NSTableView!
    
    var results = [
        "map :: (a -> b) -> [a] -> [b]",
        "map :: (a -> b) -> NonEmpty a -> NonEmpty b"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultsTable.delegate = self
        resultsTable.dataSource = self
    }
}

extension SidebarViewController: NSTableViewDelegate {
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let ident = NSUserInterfaceItemIdentifier(rawValue: "Result")
        let image = NSImage(named: "function")
        let text = results[row]
        
        if let cell = tableView.makeView(withIdentifier: ident, owner: nil) as? NSTableCellView {
            cell.textField?.stringValue = text
            cell.imageView?.image = image ?? nil
            return cell
        }
        
        return nil
    }
}

extension SidebarViewController: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 20
    }
}
