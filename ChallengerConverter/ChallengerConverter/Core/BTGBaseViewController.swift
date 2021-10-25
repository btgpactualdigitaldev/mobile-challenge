//
//  BTGBaseViewController.swift
//  ChallengerConverter
//
//  Created by ADRIANO.MAZUCATO on 22/10/21.
//

import Foundation
import UIKit


class BTGBaseViewController<V: UIView>: UIViewController {
    
    var mainView: V {
        return view as! V
    }
    
    internal init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func loadView() {
        self.view = V()
    }
}
