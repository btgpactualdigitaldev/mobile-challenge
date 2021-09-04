//
//  Helper.swift
//  CoinExchanger
//
//  Created by Edson Rottava on 09/07/21.
//

import UIKit

enum Direction {
    case top
    case bottom
    case left
    case right
}

class Helper {
    /// Return if device is in portrait mode
    class func isPortrait() -> Bool {
        return UIScreen.main.bounds.height > UIScreen.main.bounds.width
    }
    
    /// Return the height ratio for current screen agains a 667 point screen
    class func hr() -> CGFloat {
        if isPortrait() {
            return UIScreen.main.bounds.height/667
        } else {
            return UIScreen.main.bounds.width/667
        }
    }
    
    /// Return the width ratio for current screen agains a 375 point screen
    class func wr() -> CGFloat {
        if isPortrait() {
            return UIScreen.main.bounds.width/375
        } else {
            return UIScreen.main.bounds.height/375
        }
    }
    
    /// Return the safe area size for the current device
    class func safeSize(for direction: Direction) -> CGFloat {
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows[0]
            switch direction {
            case .top:
                return isPortrait() ? window.safeAreaInsets.top : window.safeAreaInsets.left
            case .bottom:
                return isPortrait() ? window.safeAreaInsets.bottom : window.safeAreaInsets.right
            case .left:
                return isPortrait() ? window.safeAreaInsets.left : window.safeAreaInsets.top
            case .right:
                return isPortrait() ? window.safeAreaInsets.right : window.safeAreaInsets.bottom
            }
        } else {
            let window = UIApplication.shared.keyWindow
            switch direction {
            case .top:
                return isPortrait() ? window?.safeAreaInsets.top ?? 0 : window?.safeAreaInsets.left ?? 0
            case .bottom:
                return isPortrait() ? window?.safeAreaInsets.bottom ?? 0 : window?.safeAreaInsets.right ?? 0
            case .left:
                return isPortrait() ? window?.safeAreaInsets.left ?? 0 : window?.safeAreaInsets.top ?? 0
            case .right:
                return isPortrait() ? window?.safeAreaInsets.right ?? 0 : window?.safeAreaInsets.bottom ?? 0
            }
        }
    }
    
    /// Return a String formated date from Date
    /// Default date = Date()
    /// Default format = "dd/MM//yyyy"
    class func getDate(_ date: Date = Date(), _ format: String = "dd/MM/yyyy") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        return dateFormatter.string(from: date)
    }
    
    /// return a Date from String
    /// Default format = "dd/MM//yyyy"
    class func getDate(_ date: String, _ format: String = "dd/MM/yyyy") -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        return dateFormatter.date(from: date) ?? Date()
    }
    
    /// Return a String formatted date from another String
    /// Default inputFormat = "dd/MM//yyyy"
    /// Default outputFormat = "dd, MMM yyyy"
    class func convertDate(_ date: String,
                           _ inputFormat: String = "dd/MM/yyyy",
                           _ outputFormat: String = "dd, MMM yyyy") -> String {
        
        return getDate(getDate(date, inputFormat), outputFormat)
    }
}
