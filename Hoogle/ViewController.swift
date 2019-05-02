//
//  ViewController.swift
//  Hoogle
//
//  Created by Zac Garby on 01/05/2019.
//  Copyright © 2019 Zac Garby. All rights reserved.
//

import Cocoa
import Alamofire

enum ResultKind {
    case function
    case type
    case module
    case package
}

struct Result {
    var kind: ResultKind
    var item: String
    var docs: String
    var module: String?
    var package: String?
}

class ViewController: NSSplitViewController {
    var results: [Result] = [
        Result(kind: .function,
               item: "map :: (a -> b) -> [a] -> [b]",
               docs: "Maps a function over a list. It is equivalent to fmap, but specialised to the [a] type.",
               module: "Prelude",
               package: "base"),
        Result(kind: .function,
               item: "fmap :: Functor f => (a -> b) -> f a -> f b",
               docs: "Maps a function over a functor.",
               module: "Prelude",
               package: "base"),
        Result(kind: .type,
               item: "data Map k a",
               docs: "A Map from keys k to values a",
               module: "Data.Map.Internal",
               package: "containers"),
        Result(kind: .module,
               item: "module Data.Map",
               docs: "Note: You should use Data.Map.Strict instead of this module",
               module: nil,
               package: "containers")
    ]
    
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
}
