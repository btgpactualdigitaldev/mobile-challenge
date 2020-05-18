//
//  LocalStorage.swift
//  BtgChallenge
//
//  Created by Felipe Alexander Silva Melo on 16/05/20.
//  Copyright © 2020 Felipe Alexander Silva Melo. All rights reserved.
//

import Foundation

enum LocalError: Error {
    case notFound
}

protocol LocalStorage {
    func setLiveCache(liveResponse: LiveResponse)
    func setListCache(listResponse: ListResponse)
    func getCachedObject<T: Decodable>() -> T?
}
