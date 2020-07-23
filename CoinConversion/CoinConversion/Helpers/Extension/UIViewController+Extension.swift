//
//  UIViewController+Extension.swift
//  CoinConversion
//
//  Created by Ronilson Batista on 18/07/20.
//  Copyright © 2020 Ronilson Batista. All rights reserved.
//

import UIKit

private var loadingView: UIView = UIView()
private var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()

extension UIViewController {
    class var nibName: String {
        return String(describing: self)
    }
    
    func showActivityIndicator() {
        if let window = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first {
            loadingView.frame = window.frame
            loadingView.center = window.center
            loadingView.backgroundColor = UIColor(hexadecimal: 0x000000).withAlphaComponent(0.5)
            loadingView.clipsToBounds = true
            loadingView.alpha = 1
            
            activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
            activityIndicator.style = .large
            activityIndicator.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2)
            
            DispatchQueue.main.async {
                loadingView.addSubview(activityIndicator)
                window.addSubview(loadingView)
            }
            
            activityIndicator.startAnimating()
        }
    }
    
    func hideActivityIndicator() {
        activityIndicator.stopAnimating()
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.2, animations: {
                loadingView.alpha = 0
            }, completion: { _ in
                loadingView.removeFromSuperview()
            })
        }
    }
    
    func configureNavigationBar(largeTitleColor: UIColor,
                                backgoundColor: UIColor,
                                tintColor: UIColor,
                                title: String,
                                preferredLargeTitle: Bool,
                                isSearch: Bool,
                                searchController: UISearchController?
    ) {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor:largeTitleColor,
                                                     .font: UIFont.systemFont(ofSize: 25)]
        navBarAppearance.titleTextAttributes = [.foregroundColor: largeTitleColor]
        navBarAppearance.backgroundColor = backgoundColor
        
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.compactAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        
        navigationController?.navigationBar.prefersLargeTitles = preferredLargeTitle
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = tintColor
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.title = title
        
        if isSearch && searchController != nil {
            navigationItem.hidesSearchBarWhenScrolling = false
            navigationItem.searchController = searchController
            navigationController?.view.backgroundColor = .white
        }
    }
    
    func topMostViewController() -> UIViewController {
        if let presented = self.presentedViewController {
            return presented.topMostViewController()
        }
        
        if let navigation = self as? UINavigationController {
            return navigation.visibleViewController?.topMostViewController() ?? navigation
        }
        
        if let tab = self as? UITabBarController {
            return tab.selectedViewController?.topMostViewController() ?? tab
        }
        
        return self
    }
}
