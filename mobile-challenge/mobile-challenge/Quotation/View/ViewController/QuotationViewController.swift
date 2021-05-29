//
//  ViewController.swift
//  mobile-challenge
//
//  Created by Caio Azevedo on 25/11/20.
//

import UIKit

class QuotationViewController: UIViewController {
    
    weak var coordinator: QuotationCoordinator?
    private var viewModel: QuotationViewModel
    
    var originCurrencyQuotation: CurrencyQuotation?
    var destinyCurrencyQuotation: CurrencyQuotation?
    
    var quotationView: QuotationView {
        return view as! QuotationView
    }
    
    init(viewModel: QuotationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = QuotationView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setUpTargets()
        quotationView.chooseCurrencyView.textValueToConvert.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func setUpTargets() {
        quotationView.chooseCurrencyView.originCurrencyButton.addTarget(self, action: #selector(makeRequest(sender:)), for: .touchUpInside)
        quotationView.chooseCurrencyView.destinyCurrencyButton.addTarget(self, action: #selector(makeRequest(sender:)), for: .touchUpInside)
        quotationView.convertButton.addTarget(self, action: #selector(convert), for: .touchUpInside)
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:))))
    }
    
    func getCurrenciesQuotation(tagButton: TagButton) {
        coordinator?.showCurrencyList()
        viewModel.getCurrenciesQuotation { (result) in
            switch result {
            case .success(let currenciesQuotation):
                self.coordinator?.currencyList?.didFinishFetchQuotations(currenciesQuotation: currenciesQuotation, tagButton: tagButton)
            case .failure(let error):
                self.coordinator?.currencyList?.didFinishFetchQuotationsWithError(error: error, tagButton: tagButton)
            }
        }
    }
    
    func verifyIfFieldsAreValid() -> Bool {
        if quotationView.chooseCurrencyView.originCurrencyButton.title(for: .normal) == "---" || quotationView.chooseCurrencyView.destinyCurrencyButton.title(for: .normal) == "---" {
            presentAlert(missingField: .buttons)
            
            return false
        } else if quotationView.chooseCurrencyView.textValueToConvert.text == "" {
            presentAlert(missingField: .textField)
            
            return false
        } else {
            return true
        }
    }
    
    func presentAlert(missingField: MissingField) {
        let alert = UIAlertController(title: missingField.title, message: missingField.menssage, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Continar", style: .default)
        alert.addAction(action)
        
        self.present(alert, animated: true)
    }
    
    
    @objc func makeRequest(sender: UIButton){
        switch sender.tag {
        case TagButton.origin.rawValue:
            getCurrenciesQuotation(tagButton: TagButton.origin)
        default:
            getCurrenciesQuotation(tagButton: TagButton.destiny)
        }
        
    }
    
    @objc func convert() {
        let isValid = verifyIfFieldsAreValid()
        
        if isValid {
            guard let valueStr = quotationView.chooseCurrencyView.textValueToConvert.text else { return }
            guard let origin = originCurrencyQuotation else { return }
            guard let destiny = destinyCurrencyQuotation else { return }
            
            let value = Double(valueStr) ?? 0.0
            
            let convertedValue = viewModel.convert(value: value, origin: origin.quotation, destiny: destiny.quotation)
            
            quotationView.chooseCurrencyView.resultLabel.text = convertedValue
        }
    }
}

extension QuotationViewController {
    func updateUI(currencyQuotation: CurrencyQuotation, tagButton: TagButton) {
        if tagButton == .origin {
            self.quotationView.chooseCurrencyView.originCurrencyButton.setTitle(currencyQuotation.code, for: .normal)
            self.originCurrencyQuotation = currencyQuotation
        } else {
            quotationView.chooseCurrencyView.destinyCurrencyButton.setTitle(currencyQuotation.code, for: .normal)
            self.destinyCurrencyQuotation = currencyQuotation
        }
    }
}

extension QuotationViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            
        if string.count == 0 { return true }
        
        if let newText = convertText(string: string, range: range, text: textField.text) {
            quotationView.chooseCurrencyView.textValueToConvert.text = newText
        }
        
        return false
    }
    
    func convertText(string: String, range: NSRange, text: String?) -> String? {

        let givenText = text ?? ""
        
        var newText = (givenText as NSString).replacingCharacters(in: range, with: string) as NSString
        
        newText = newText.replacingOccurrences(of: ".", with: "") as NSString

        let cents : NSInteger = newText.integerValue
        let value = (Double(cents) / 100.0)

        if newText.length < 9 {
            let str = String(format: "%0.2f", arguments: [value])
            return str
        }
        
        return nil
    }
}

