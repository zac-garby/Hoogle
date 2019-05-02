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
    
    var results: [Result] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultsTable.delegate = self
        resultsTable.dataSource = self
    }
    
    func updateData() {
        resultsTable.reloadData()
    }
}

extension SidebarViewController: NSTableViewDelegate {
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let ident = NSUserInterfaceItemIdentifier(rawValue: "Result")
        let image: NSImage
        let result = results[row]
        
        switch result.kind {
        case .function:
            image = NSImage(named: "function")!
        case .module:
            image = NSImage(named: "module")!
        case .package:
            image = NSImage(named: "package")!
        case .type:
            image = NSImage(named: "type")!
        }
        
        if let cell = tableView.makeView(withIdentifier: ident, owner: nil) as? NSTableCellView {
            cell.textField?.stringValue = result.item
            cell.imageView?.image = image
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
