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
        
        if let cell = tableView.makeView(withIdentifier: ident, owner: nil) as? ResultCellView {
            cell.item.stringValue = result.item
            
            if let module = result.module {
                cell.module.stringValue = module
            } else {
                cell.module.removeFromSuperview()
            }
            
            if let package = result.package {
                cell.package.stringValue = package
            } else {
                cell.package.removeFromSuperview()
            }
            
            cell.icon.image = image
            return cell
        }
        
        return nil
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        if resultsTable.selectedRow >= 0 {
            (parent as! ViewController).select(index: resultsTable.selectedRow)
        }
    }
}

extension SidebarViewController: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        let result = results[row]
        var height = 30
        
        if let _ = result.package {
            height += 15
        }
        
        if let _ = result.module {
            height += 15
        }
        
        return CGFloat(height)
    }
}
