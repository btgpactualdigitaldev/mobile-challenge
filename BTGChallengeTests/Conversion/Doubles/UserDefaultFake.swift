//
//  UserDefaultFake.swift
//  BTGChallengeTests
//
//  Created by Mateus Rodrigues on 28/03/22.
//

import UIKit
@testable import BTGChallenge

final class UserDefaultFake: UserDefaults {

    var setBoolIsCalled: Bool = false
    var listItemsString: [String: String] = [:]
    var listItemsBool: [String: Int] = [:]
    
    override func bool(forKey defaultName: String) -> Bool {
        return listItemsBool[defaultName] == 1 ? true : false
    }
    
    override func string(forKey defaultName: String) -> String? {
        return listItemsString[defaultName]
    }
    
    override func set(_ value: Any?, forKey defaultName: String) {
        listItemsString[defaultName] = value as? String
    }
    
    override func set(_ value: Bool, forKey defaultName: String) {
        listItemsBool[defaultName] = value.hashValue
        setBoolIsCalled = true
    }
    
}
