//
//  Reusable.swift
//  mobileChallenge
//
//  Created by Renato Carvalhan on 03/12/20.
//  Copyright © 2020 Renato Carvalhan. All rights reserved.
//

import UIKit.UINib

protocol Reusable: AnyObject {
    static var reuseIdentifier: String { get }
    static var nib: UINib? { get }
    static var bundle: Bundle? { get }
}

extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }

    static var nib: UINib? {
        let nibName = String(describing: self)
        guard bundle?.path(forResource: nibName, ofType: "nib") != nil else {
            return nil
        }

        return UINib(nibName: nibName, bundle: bundle)
    }

    static var bundle: Bundle? {
        return Bundle(for: self)
    }
}

