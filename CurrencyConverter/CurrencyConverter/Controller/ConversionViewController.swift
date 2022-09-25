//
//  ConversionViewController.swift
//  CurrencyConverter
//
//  Created by Augusto Henrique de Almeida Silva on 06/10/20.
//

// API Access Key = a021e370f5dfb46097ade794a2a40ef2
// https://api.currencylayer.com/list? access_key = YOUR_ACCESS_KEY - get list of keys
// https://api.currencylayer.com/live? access_key = YOUR_ACCESS_KEY - get quotes in relation to USD

import UIKit

class ConversionViewController: UIViewController {
    
    @IBOutlet weak var valueLabel: UITextField!
    @IBOutlet weak var coinOriginButton: UIButton!
    @IBOutlet weak var coinDestinyButton: UIButton!
    @IBOutlet weak var convertedValueLabel: UILabel!
    @IBOutlet weak var lastUpdateLabel: UILabel!
    
    private var buttonTappedTag: Int = 0
    
    var viewModel: ConversionViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ViewUtils.showLoading(viewController: self)
        
        self.viewModel = ConversionViewModel()
        self.viewModel.delegate = self
        
        valueLabel.delegate = self
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        valueLabel.addTarget(self, action: #selector(myTextFieldDidChange(_:)), for: .editingChanged)
        
        title = NSLocalizedString("title_conversion_view_controller", comment: "")
    }
    
    @objc func myTextFieldDidChange(_ textField: UITextField) {
        if let amountString = textField.text?.currencyInputFormatting() {
            textField.text = amountString
        }
    }
    
    @IBAction func selectCoinAction(_ sender: Any) {
        buttonTappedTag = (sender as AnyObject).tag
        let conversionListTableViewController = ConversionListTableViewController()
        conversionListTableViewController.delegate = self
        self.navigationController?.pushViewController(conversionListTableViewController, animated: true)
    }
}

extension ConversionViewController: ConversionListTableViewDelegate {
    func receiveSelectedCoin(coinModel: CoinViewModel) {
        if buttonTappedTag == 0 {
            coinOriginButton.setTitle("\(coinModel.initials) - \(coinModel.name)", for: .normal)
            viewModel.setOriginCoin(model: coinModel)
        }
        
        if buttonTappedTag == 1 {
            coinDestinyButton.setTitle("\(coinModel.initials) - \(coinModel.name)", for: .normal)
            viewModel.setDestinyCoin(model: coinModel)
        }
    }
}

extension ConversionViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let text = textField.text ?? ""
        
        if text.digits.count > 15 && !string.isEmpty {
            return false
        }
        
        var newText = string.isEmpty ? (String(text.dropLast())) : (text + string)
        
        newText = newText.currencyInputFormatting()
        
        guard let value = newText.isEmpty ? 0.00 : Double(newText) else { return false }
        viewModel.setValue(value: value)
        return true
    }
}

extension ConversionViewController: ConversionViewModelDelegate {
    func setLastUpdate(text: String) {
        ViewUtils.hideLoading()
        DispatchQueue.main.async {
            self.lastUpdateLabel.text = NSLocalizedString("last_update", comment: "") + text
        }
    }
    
    func didErrorOcurred(error: String) {
        ViewUtils.hideLoading()
        DispatchQueue.main.async {
            ViewUtils.alert(self, title: NSLocalizedString("Erro", comment: ""), error, btnLabel: NSLocalizedString("understand", comment: ""), completion: nil, onOK: nil)
        }
    }
    
    func didConvertValue(value: String) {
        convertedValueLabel.text = value
    }
}
