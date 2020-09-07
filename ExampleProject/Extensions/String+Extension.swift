//
//  String+Extension.swift
//  ExampleProject
//
//  Created by Lucas Mathielo Gomes on 07/09/20.
//  Copyright © 2020 Lucas Mathielo Gomes. All rights reserved.
//

import UIKit

extension String {
    
    fileprivate var numerics: CharacterSet { return CharacterSet(charactersIn: "0123456789.") }
    
    func numericDigit() -> Bool {
        return self != self.components(separatedBy: self.numerics).joined()
    }
}
