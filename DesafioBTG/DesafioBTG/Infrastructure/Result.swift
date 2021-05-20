//
//  Result.swift
//  DesafioBTG
//
//  Created by Any Ambria on 12/12/20.
//  Copyright © 2020 Any Ambria. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case error(Error)
}
