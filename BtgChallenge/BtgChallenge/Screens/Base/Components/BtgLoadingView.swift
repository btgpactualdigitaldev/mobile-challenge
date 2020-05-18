//
//  BtgLoadingView.swift
//  BtgChallenge
//
//  Created by Felipe Alexander Silva Melo on 13/05/20.
//  Copyright © 2020 Felipe Alexander Silva Melo. All rights reserved.
//

import UIKit

class BtgLoadingView: UIView {
    
    enum LoadingStatus: Int {
        case stopped
        case running
    }
    
    private var loadingStatus: LoadingStatus = .stopped
    static let shared = BtgLoadingView()
    
    private var presenterView: UIView?
    
    lazy var activity: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .large)
        activity.tintColor = UIColor.darkBlue
        activity.color = UIColor.darkBlue
        return activity
    }()
    
    convenience init() {
        self.init(frame: UIScreen.main.bounds)
    }
    
    required convenience public init?(coder aDecoder: NSCoder) {
        self.init(frame: UIScreen.main.bounds)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isOpaque = false
        backgroundColor = .clear
        
        activity.frame = UIScreen.main.bounds
        
        addSubview(activity)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.onAppTimeout),
            name: Constants.Notifications.appTimeout,
            object: nil
        )
    }
    
    @objc func onAppTimeout(notification: NSNotification) {
        close()
    }
    
    public func open() {
        loadingStatus = .running
        activity.startAnimating()
        
        let currentWindow: UIWindow? = UIApplication.shared.windows.first
        currentWindow?.addSubview(self)
        
        activity.frame = UIScreen.main.bounds
    }
    
    @objc public func close() {
        loadingStatus = .stopped
        activity.stopAnimating()
        removeFromSuperview()
        
    }
    
    static func status() -> LoadingStatus {
        return shared.loadingStatus
    }
    
    static func start() {
        shared.open()
    }
    
    static func stop() {
        shared.close()
    }
    
}
