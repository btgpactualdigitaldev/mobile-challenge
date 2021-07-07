//
//  EmptyLabel.swift
//  CurrencyConverter
//
//  Created by Tiago Chaves on 14/02/20.
//  Copyright © 2020 Tiago Chaves. All rights reserved.
//

import UIKit

class EmptyLabel: UILabel {

    convenience init(forView view:UIView, andMessage message:String?) {
        let frame = CGRect(origin: CGPoint(x: 0, y: 0), size: view.frame.size)
        self.init(frame: frame)
        self.text                  = message ?? ""
        self.textAlignment         = .center
        self.numberOfLines         = 2
    }
}
