//
//  StringExtension.swift
//  ChallengerConverter
//
//  Created by ADRIANO.MAZUCATO on 24/10/21.
//

import Foundation


extension String {
    func caseInsensitiveContain(_ string: String)-> Bool {
        return self.lowercased().contains(string.lowercased())
    }
}
