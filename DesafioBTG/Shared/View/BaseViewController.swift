//
//  BaseViewController.swift
//  DesafioBTG
//
//  Created by Robson Moreira on 17/02/20.
//  Copyright © 2020 Robson Moreira. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    var contentView: UIView!
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    static var className: String {
        return String(describing: self)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func setup() {
        preconditionFailure("This method must be overridden")
    }
    
    func showAlert(title: String, message: String, handler: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: handler)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showConfirm(title: String, message: String, positive: String = "OK", negative: String = "Cancelar", handler: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertActionCancel = UIAlertAction(title: negative, style: .cancel, handler: nil)
        let alertActionOk = UIAlertAction(title: positive, style: .default, handler: handler)
        alertController.addAction(alertActionCancel)
        alertController.addAction(alertActionOk)
        self.present(alertController, animated: true, completion: nil)
    }
    
}
