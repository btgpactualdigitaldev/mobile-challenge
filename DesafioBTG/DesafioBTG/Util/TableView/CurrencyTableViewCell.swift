//
//  CurrencyTableViewCell.swift
//  DesafioBTG
//
//  Created by Rodrigo Goncalves on 05/11/20.
//

import Foundation
import UIKit

class CurrencyTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var lblInitials: UILabel!
    @IBOutlet weak var lblFullName: UILabel!
    
    var data: CurrencyInfo? {
        didSet {
            lblInitials.text = data?.initial
            lblFullName.text = data?.fullName
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ seleded: Bool, animated: Bool){
        super.setSelected(seleded, animated: animated)
    }
}
