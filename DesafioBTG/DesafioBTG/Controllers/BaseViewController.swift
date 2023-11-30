//
//  BaseViewController.swift
//  DesafioBTG
//
//  Created by Admin Colaborador on 09/11/20.
//

import UIKit

class BaseViewController: UIViewController {
    
    private var viewLoading: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: Function`s
    func showLoading(onView: UIView, show: Bool) {
        
        if show {
            
            let spin = UIView.init(frame: onView.bounds)
            spin.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
            
            let activityIndicator = UIActivityIndicatorView.init(style: .whiteLarge)
            activityIndicator.startAnimating()
            activityIndicator.center = spin.center
            
            DispatchQueue.main.async {
                spin.addSubview(activityIndicator)
                onView.addSubview(spin)
            }
            
            viewLoading = spin
        } else {
            DispatchQueue.main.async {
                self.viewLoading?.removeFromSuperview()
                self.viewLoading = nil
            }
        }
        
    }
}
