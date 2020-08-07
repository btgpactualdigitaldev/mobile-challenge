//
//  Helpers.swift
//  BTGCurrency
//
//  Created by Raphael Martin on 04/08/20.
//  Copyright © 2020 Raphael Martin. All rights reserved.
//

import Foundation
import UIKit
import SystemConfiguration

func inMainThread(_ callback: @escaping () -> Void) {
    DispatchQueue.main.async {
        callback()
    }
}

func alert(title: String, message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

    Router.shared.presentViewController(viewController: alert)
}

extension String {
    var noLeadingZeros: String {
        return self.replacingOccurrences(of: "^0+", with: "", options: .regularExpression)
    }
}

extension NSObject {
    class var className: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}

protocol NetworkHelperProtocol {
    func isConnected() -> Bool
}

class NetworkHelper : NetworkHelperProtocol {
    func isConnected() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)

        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }

        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }

        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)

        return (isReachable && !needsConnection)
    }
    
}

extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}
