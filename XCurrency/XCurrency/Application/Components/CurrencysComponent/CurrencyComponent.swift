//
//  CurrencyComponent.swift
//  XCurrency
//
//  Created by Vinicius Nadin on 27/03/21.
//

import UIKit

class CurrencyComponent: UIView {

    // MARK: - Outlets
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var iconView: UIView!
    @IBOutlet weak var valueTextField: UITextField!
    @IBOutlet weak var iconLabel: UILabel!
    
    // MARK: - Initialziers
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }

    // MARK: - Private Methods
    private func setup() {
        let nib = UINib(nibName: "CurrencyComponent", bundle: nil)
        let view: UIView = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = self.bounds
        self.addSubview(view)
    }

    // MARK: - Public Methods
    func setCurrency(currency: Currency?) {
        if let currency = currency {
            self.codeLabel.text = currency.code
            self.nameLabel.text = "(\(currency.name))"
        } else {
            self.codeLabel.text = "SAC"
            self.nameLabel.text = "Select a currency!"
            self.valueTextField.text = "0.0"
        }
    }
}
