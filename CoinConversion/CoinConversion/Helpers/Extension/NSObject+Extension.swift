//
//  NSObject+Extension.swift
//  CoinConversion
//
//  Created by Ronilson Batista on 19/07/20.
//  Copyright © 2020 Ronilson Batista. All rights reserved.
//

import Foundation

protocol Identifying { }

extension Identifying where Self : NSObject {
    static var identifier: String { return String(describing: self) }
    
    var className: String {
        return String(describing: type(of: self)).components(separatedBy: ".").last!
    }
}

extension NSObject: Identifying { }
