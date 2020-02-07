//
//  Result.swift
//  BTGTesteChallenge
//
//  Created by Rafael  Hieda on 2/5/20.
//  Copyright © 2020 Rafael_Hieda. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case error(Error)
}
