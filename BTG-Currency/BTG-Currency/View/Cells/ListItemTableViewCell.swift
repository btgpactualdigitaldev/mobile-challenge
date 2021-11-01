//
//  ListItemTableViewCell.swift
//  BTG-Currency
//
//  Created by Ramon Almeida on 28/10/21.
//

import UIKit

class ListItemTableViewCell: UITableViewCell {
    //MARK: - Outlets
    @IBOutlet weak var layerView: UIView!
    @IBOutlet weak var flagLabel: UILabel!
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var countryNameLabel: UILabel!
    
    //MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        layerView.layer.cornerRadius = 20
    }
    
    //MARK: - Methods
    private func flag(country: String) -> String {
        let base: UInt32 = 127397
        var s = ""
        for v in country.unicodeScalars {
            s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
        }
        return String(s)
    }
    
    public func setup(code: String, countryName: String) {
        if let locale = Locale.getLocale(byCurrencyCode: code), let regionCode = locale.regionCode {
            flagLabel.text = flag(country: regionCode)
        } else {
            flagLabel.isHidden = true
        }
        codeLabel.text = code
        countryNameLabel.text = countryName
    }
}
