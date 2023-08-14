//
//  String+Extension.swift
//  DesafioBTG
//
//  Created by Bittencourt Mantavani, Rômulo on 03/09/20.
//  Copyright © 2020 Bittencourt Mantovani, Rômulo. All rights reserved.
//

import Foundation


extension String{
    var numbersOnly: String {
        components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    }
}
