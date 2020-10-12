//
//  UIViewController+extension.swift
//  Challenge
//
//  Created by Eduardo Raffi on 11/10/20.
//  Copyright © 2020 Eduardo Raffi. All rights reserved.
//

import UIKit

var loadingView : UIView?

extension UIViewController {
    
    func showErrorAlert(message: String, title: String = "Error") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }

    func startLoading(onView : UIView) {
        let loading = UIView.init(frame: onView.bounds)
        loading.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let activityIndicator = UIActivityIndicatorView.init(style: .large)
        activityIndicator.startAnimating()
        activityIndicator.center = loading.center

        DispatchQueue.main.async {
            loading.addSubview(activityIndicator)
            onView.addSubview(loading)
            loading.translatesAutoresizingMaskIntoConstraints = false
            activityIndicator.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                loading.topAnchor.constraint(equalTo: onView.safeAreaLayoutGuide.topAnchor),
                loading.leadingAnchor.constraint(equalTo: onView.safeAreaLayoutGuide.leadingAnchor),
                loading.trailingAnchor.constraint(equalTo: onView.safeAreaLayoutGuide.trailingAnchor),
                loading.bottomAnchor.constraint(equalTo: onView.safeAreaLayoutGuide.bottomAnchor),
                
                activityIndicator.centerXAnchor.constraint(equalTo: loading.centerXAnchor),
                activityIndicator.centerYAnchor.constraint(equalTo: loading.centerYAnchor)
            ])
        }

        loadingView = loading
    }
    
    func stopLoading() {
        DispatchQueue.main.async {
            loadingView?.removeFromSuperview()
            loadingView = nil
        }
    }

}
