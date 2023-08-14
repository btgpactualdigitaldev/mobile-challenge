//
//  UIViewController+Extension.swift
//  DesafioBTG
//
//  Created by Bittencourt Mantavani, Rômulo on 03/09/20.
//  Copyright © 2020 Bittencourt Mantovani, Rômulo. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showObstructiveLoading() {
        if  let appDelegate = UIApplication.shared.delegate as? AppDelegate,
            let window = appDelegate.window,
            window.viewWithTag(951753) == nil{
            let overlayView = UIView(frame: window.frame)
            overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
            overlayView.clipsToBounds = true
            overlayView.tag = 951753
            let loadingView = LoadingView(frame: CGRect(x: (overlayView.frame.height / 2) - 40,
                                                        y: (overlayView.frame.width / 2) - 40,
                                                        width: 80,
                                                        height: 80))
            
            overlayView.addSubview(loadingView)
            
            window.addSubview(overlayView)
            
            loadingView.animate()
        }
        
    }
    
    func hideObstructiveLoading() {
        if  let appDelegate = UIApplication.shared.delegate as? AppDelegate,
        let window = appDelegate.window,
        let overlayView = window.viewWithTag(951753){
            overlayView.removeFromSuperview()
        }
    }
    
    var wrapedNavigation: UINavigationController {
        let nav = UINavigationController()
        nav.viewControllers = [self]
        return nav
    }
}
