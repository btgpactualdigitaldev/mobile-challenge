//
//  BtgLabelLarge.swift
//  BtgChallenge
//
//  Created by Felipe Alexander Silva Melo on 13/05/20.
//  Copyright © 2020 Felipe Alexander Silva Melo. All rights reserved.
//

import UIKit

final class BtgLabelLarge: BtgLabel {

    override var labelFont: UIFont {
        return UIFont.btgLabelLarge() ?? UIFont()
    }

}
