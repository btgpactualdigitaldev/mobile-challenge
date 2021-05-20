//
//  Loading.swift
//  DesafioBTG
//
//  Created by Any Ambria on 13/12/20.
//  Copyright © 2020 Any Ambria. All rights reserved.
//

import Foundation
import UIKit

class Loading {
    static var vc = LoadViewController()
    
    func show(viewController: UIViewController) {
        
        Loading.vc.modalPresentationStyle = .overFullScreen
        viewController.present(Loading.vc, animated: true, completion: nil)
    }
    
    func hide() {
        DispatchQueue.main.async {
            Loading.self.vc.dismiss(animated: true, completion: nil)
        }
        
    }
}
