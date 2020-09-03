//
//  Locale+Extension.swift
//  DesafioBTG
//
//  Created by Bittencourt Mantavani, Rômulo on 03/09/20.
//  Copyright © 2020 Bittencourt Mantovani, Rômulo. All rights reserved.
//

import Foundation

extension Locale {
    init(currencyCode code: String) {
        self = Locale.availableIdentifiers.map { Locale(identifier: $0) }.first { $0.currencyCode == code } ?? Locale(identifier: "en_US")
    }
}
