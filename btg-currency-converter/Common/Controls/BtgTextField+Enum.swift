//
//  BtgTextField+Enum.swift
//  Btg
//
//  Created by Paulo Roberto Cremonine Junior on 03/01/20.
//  Copyright © 2020 Btg. All rights reserved.
//

import Foundation
public enum ImputType: Int {
    case normal
    case outLine
}

public enum ImputMask: Int {
    case none
    case email
    case date
    case celPhone
    case cpf
    case money
}
