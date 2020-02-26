//
//  GenericAPIStore.swift
//  DesafioBTG
//
//  Created by Robson Moreira on 17/02/20.
//  Copyright © 2020 Robson Moreira. All rights reserved.
//

import Foundation

protocol GenericStore {
    typealias completion<T> = (_ result: T, _ failure: Error?) -> Void
}

class GenericAPIStore {
    
    var error = NSError(domain: "", code: 901, userInfo: [NSLocalizedDescriptionKey: "Error getting information"])
    
}
