//
//  BaseTableViewCell.swift
//  DesafioBTG
//
//  Created by Robson Moreira on 17/02/20.
//  Copyright © 2020 Robson Moreira. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    static var className: String {
        return String(describing: self)
    }
    
    static var classId: String {
        let className = String(describing: self)
        return className.replacingOccurrences(of: "Cell", with: "Identifier")
    }

}
