//
//  Result.swift
//  Hoogle
//
//  Created by Zac Garby on 03/05/2019.
//  Copyright © 2019 Zac Garby. All rights reserved.
//

import Foundation

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
