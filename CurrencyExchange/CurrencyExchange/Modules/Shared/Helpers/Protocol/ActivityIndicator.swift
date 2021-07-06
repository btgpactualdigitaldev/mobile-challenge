//
//  ActivityIndicator.swift
//  CurrencyExchange
//
//  Created by Carlos Fontes on 01/11/20.
//

import UIKit

protocol ActivityIndicator {
    var loadingIndicatorView: UIView? { get set }
    var activityIndicator: UIActivityIndicatorView? { get set }
    
    mutating func showLoadingIndicator(view: UIView)
    mutating func dismissLoadingIndicator()
    
}

extension ActivityIndicator {
    
    mutating func showLoadingIndicator(view: UIView){
        loadingIndicatorView = UIView(frame: .zero)
        activityIndicator = UIActivityIndicatorView(style: .large)
        
        guard let loadingView = loadingIndicatorView, let activityIndicator = activityIndicator else {
            return
        }
        
        activityIndicator.startAnimating()
        view.addSubview(loadingView)
        loadingView.addSubview(activityIndicator)
        
        loadingView.anchor(top: view.topAnchor)
        loadingView.anchor(left: view.leftAnchor)
        loadingView.anchor(right: view.rightAnchor)
        loadingView.anchor(bottom: view.bottomAnchor)
        
        activityIndicator.centerX(in: loadingView)
        activityIndicator.centerY(in: loadingView)
    }
    
    mutating func dismissLoadingIndicator(){
        guard let loadingView = loadingIndicatorView, let activityIndicator = activityIndicator else {
            return
        }
        activityIndicator.stopAnimating()
        loadingView.removeFromSuperview()
        loadingIndicatorView = nil
    }
}
