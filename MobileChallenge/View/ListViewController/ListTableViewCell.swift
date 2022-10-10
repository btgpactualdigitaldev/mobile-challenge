//
//  ListTableViewCell.swift
//  MobileChallenge
//
//  Created by Thiago de Paula Lourin on 14/10/20.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    private(set) var code: String?
    private(set) var name: String?
    
    func initView(code: String, name: String) {
        self.code = code
        self.name = name
        
        fillCell()
    }
    
    private func fillCell() {
        self.codeLabel.text = code ?? ""
        self.nameLabel.text = name ?? ""
    }
    
}
