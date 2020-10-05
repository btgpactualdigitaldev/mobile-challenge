//
//  OSLog.swift
//  btg-mobile-challenge
//
//  Created by Artur Carneiro on 04/10/20.
//
//swiftlint:disable force_unwrapping
import Foundation
import os.log

extension OSLog {
    private static let subsystem: String = Bundle.main.bundleIdentifier!

    static let networking: OSLog = OSLog(subsystem: subsystem, category: "networking")
    static let appflow: OSLog = OSLog(subsystem: subsystem, category: "appflow")
}
