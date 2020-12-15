//
//  ProgressView.swift
//  CurrencyConverter
//
//  Created by Italo Boss on 14/12/20.
//

import UIKit

class ProgressView {
    
    var containerView = UIView()
    var progressView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    
    func show() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        containerView.frame = window.frame
        containerView.center = window.center
        containerView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        
        progressView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        progressView.center = window.center
        progressView.backgroundColor = UIColor.gray.withAlphaComponent(0.4)
        progressView.clipsToBounds = true
        progressView.layer.cornerRadius = 40
        
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator.style = .large
        activityIndicator.center = CGPoint(x: progressView.bounds.width / 2, y: progressView.bounds.height / 2)
        
        progressView.addSubview(activityIndicator)
        containerView.addSubview(progressView)
        UIApplication.shared.keyWindow?.addSubview(containerView)
        
        activityIndicator.startAnimating()
    }
    
    func hide() {
        activityIndicator.stopAnimating()
        containerView.removeFromSuperview()
    }
}
