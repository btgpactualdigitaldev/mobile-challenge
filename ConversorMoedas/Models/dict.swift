//
//  dict.swift
//  ConversorMoedas
//
//  Created by Ricardo Santana Lopes on 13/08/20.
//  Copyright © 2020 Ricardo Santana Lopes. All rights reserved.
//

import Foundation

extension Dictionary{
    subscript(i:Int) -> (key:Key, value:Value){
        get{
            return self[index(startIndex,offsetBy: i)]
        }
    }
}
