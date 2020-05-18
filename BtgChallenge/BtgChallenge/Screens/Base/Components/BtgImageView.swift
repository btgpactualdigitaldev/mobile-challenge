//
//  BtgImageView.swift
//  BtgChallenge
//
//  Created by Felipe Alexander Silva Melo on 11/05/20.
//  Copyright © 2020 Felipe Alexander Silva Melo. All rights reserved.
//

import UIKit

class BtgImageView: UIImageView {
    
    init(imageName: String) {
        super.init(frame: .zero)
        
        let image = UIImage(named: imageName, in: Bundle.main, compatibleWith: nil)
        self.image = image
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
