//
//  Result.swift
//  BTGChallenge
//
//  Created by Gerson Vieira on 14/06/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import Foundation
enum Result<T> {
    case success(T)
    case failure(Error)
}
