//
//  LocalStorageSpy.swift
//  BtgChallengeTests
//
//  Created by Felipe Alexander Silva Melo on 17/05/20.
//  Copyright © 2020 Felipe Alexander Silva Melo. All rights reserved.
//

import Foundation
@testable import BtgChallenge

class LocalStorageSpy: LocalStorage {
    var setLiveCacheCalled = false
    var setListCacheCalled = false
    var getCachedObjectCalled = false
    
    var liveResponse: LiveResponse?
    var listResponse: ListResponse?
    
    func setLiveCache(liveResponse: LiveResponse) {
        self.liveResponse = liveResponse
        setLiveCacheCalled = true
    }
    
    func setListCache(listResponse: ListResponse) {
        self.listResponse = listResponse
        setListCacheCalled = true
    }
    
    func getCachedObject<T: Decodable>() -> T? {
        getCachedObjectCalled = true
        return liveResponse as? T ?? listResponse as? T
    }
}
