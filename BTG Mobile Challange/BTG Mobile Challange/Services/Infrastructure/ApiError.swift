//
//  ApiError.swift
//  BTG Mobile Challange
//
//  Created by Uriel Barbosa Pinheiro on 23/09/20.
//  Copyright © 2020 Uriel Barbosa Pinheiro. All rights reserved.
//

import Foundation

enum ApiError: Error {
    case genericError
    case apiError(errorDescription: String?)
}
