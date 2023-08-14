//
//  URLRequest+Extension.swift
//  DesafioBTG
//
//  Created by Bittencourt Mantavani, Rômulo on 02/09/20.
//  Copyright © 2020 Bittencourt Mantovani, Rômulo. All rights reserved.
//

import Foundation

extension URLRequest {
    mutating func addParameter(_ param: String, forKey key: String) {
        guard var currentUrl = self.url?.absoluteString else { return }
        
        if currentUrl.contains("?") {
            currentUrl += "&" + (key + "=" + param)
        } else {
            currentUrl += "?" + (key + "=" + param)
        }
        self.url = URL(string: currentUrl)
    }
}
