//
//  Result.swift
//  iOSBTG
//
//  Created by Filipe Merli on 10/06/20.
//  Copyright © 2020 Filipe Merli. All rights reserved.
//

import Foundation

public enum Result<T, U: Error> {
    case success(T)
    case failure(U)
}
