//
//  UITableViewExtension.swift
//  CurrencyConverter
//
//  Created by Eduardo Lopes on 30/09/21.
//

import UIKit

extension UITableView {
    
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
        messageLabel.sizeToFit()
        
        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }
    
    func setLoad() {
        let activity: UIActivityIndicatorView = {
            let activity = UIActivityIndicatorView()
            activity.hidesWhenStopped = true
            activity.startAnimating()
            return activity
        }()
        
        self.backgroundView = activity
        self.separatorStyle = .none
    }
    
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
