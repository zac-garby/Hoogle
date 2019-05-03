//
//  ResultCellView.swift
//  Hoogle
//
//  Created by Zac Garby on 03/05/2019.
//  Copyright © 2019 Zac Garby. All rights reserved.
//

import Cocoa

class ResultCellView: NSTableCellView {
    @IBOutlet weak var icon: NSImageView!
    @IBOutlet weak var item: NSTextField!
    @IBOutlet weak var module: NSTextField!
    @IBOutlet weak var package: NSTextField!
}
