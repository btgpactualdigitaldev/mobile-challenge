//
//  UITableViewExtension.swift
//  mobile-challenge
//
//  Created by Marcos Fellipe Costa Silva on 25/04/21.
//

import Foundation
import UIKit

extension UITableView {
    func setEmptyView(message: String) {
        if !message.isEmpty {
            let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
            let messageLabel = UILabel()
            messageLabel.translatesAutoresizingMaskIntoConstraints = false
            messageLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
            messageLabel.numberOfLines = 2
            messageLabel.textAlignment = .center
            messageLabel.lineBreakMode = .byTruncatingMiddle
            emptyView.addSubview(messageLabel)
            messageLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
            messageLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
            messageLabel.leadingAnchor.constraint(equalTo: emptyView.leadingAnchor, constant: 15).isActive = true
            messageLabel.trailingAnchor.constraint(equalTo: emptyView.trailingAnchor, constant: -15).isActive = true
            messageLabel.text = message
            // The only tricky part is here:
            self.backgroundView = emptyView
        } else {
            self.backgroundView = nil
            
        }
    }
    
    func pullToRefresh(completion: @escaping (() -> ())) {
        self.refreshControl = UIRefreshControl()
        self.actionHandler(action: completion)
        refreshControl?.addTarget(self, action: #selector(triggerActionHandler), for: .valueChanged)
    }
    
    func stopPullToRefresh() {
        guard let refreshControl = refreshControl else {return}
        refreshControl.endRefreshing()
    }
    
    private func actionHandler(action:(() -> Void)? = nil) {
        struct __ { static var action :(() -> Void)? }
        if action != nil { __.action = action }
        else { __.action?() }
    }
    
    @objc private func triggerActionHandler() {
        self.actionHandler()
    }
}
