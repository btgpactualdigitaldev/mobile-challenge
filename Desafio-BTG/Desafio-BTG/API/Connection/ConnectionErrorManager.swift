//
//  ConnectionErrorManager.swift
//  Desafio-BTG
//
//  Created by Euclides Medeiros on 31/03/21.
//

import Foundation
import UIKit

class ConnectionErrorManager {
    static func isSuccessfulStatusCode(statusCode: Int) -> Bool {
        if (statusCode >= 200 && statusCode < 300) {
            return true
        }
    return false
    }
}
