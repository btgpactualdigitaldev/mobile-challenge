//
//  SearchBarDelegateSpy.swift
//  BTGChallengeTests
//
//  Created by Mateus Rodrigues on 28/03/22.
//

import UIKit
@testable import BTGChallenge

class SearchBarDelegateSpy: SearchBarDelegate {
    
    var isSearchBarIsCalled = false
    var isSearchBarControllerIsCalled = false
    
    func textDidChangeSearchBar(_ text: String, _ scope: Int) {
        isSearchBarIsCalled = true
    }
    
    func textDidChangeSearchController(_ text: String, _ scope: Int) {
        isSearchBarControllerIsCalled = true
    }
    
}
