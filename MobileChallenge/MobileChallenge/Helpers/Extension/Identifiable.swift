//
//  Identifiable.swift
//  MobileChallenge
//
//  Created by Jonatas Coutinho de Faria on 04/11/20.
//

import Foundation

import UIKit

protocol Identifiable: AnyObject {
    static var uniqueIdentifier: String { get }
}

extension Identifiable {
    static var uniqueIdentifier: String {
        String(describing: self)
    }
}

extension UITableViewCell: Identifiable {}
