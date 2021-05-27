//
//  StoryboardLodable.swift
//  CurrencyConverter
//
//  Created by Renan Santiago on 11/08/20.
//  Copyright © 2020 Renan Santiago. All rights reserved.
//

import Foundation
import UIKit

protocol StoryboardLodable: AnyObject {
    @nonobjc static var storyboardName: String { get }
}

protocol CurrenciesStoryboardLodable: StoryboardLodable {
}

extension CurrenciesStoryboardLodable where Self: UIViewController {
    @nonobjc static var storyboardName: String {
        return "Currencies"
    }
}
