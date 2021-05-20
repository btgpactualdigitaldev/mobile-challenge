//
//  ConvertViewController.swift
//  DesafioBTG
//
//  Created by Any Ambria on 13/12/20.
//  Copyright © 2020 Any Ambria. All rights reserved.
//

import UIKit

class ConvertViewController: UIViewController {
    @IBOutlet weak var valueTextField: UITextField?
    @IBOutlet weak var firstTextField: UITextField?
    @IBOutlet weak var secondTextField: UITextField?
    @IBOutlet weak var errorView: UIView?
    @IBOutlet weak var selectFirstStackView: UIStackView?
    @IBOutlet weak var resultLabel: UILabel?
    @IBOutlet weak var selectSecondStackView: UIStackView?
    
    var viewModel: CurrenciesViewModel?
    var typeField: String?
    var quoteFirst: Double?
    var quoteSecond: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CurrenciesViewModel(currenciesProvider: CurrenciesProvider(), viewController: self)
        taps()
        bindElements()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel?.fetchQuotesCurrencies()
    }
    
    func bindElements() {
        viewModel?.errorQuotes.bind(skip: true, { [weak self] (errored) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if errored  {
                    self.errorView?.isHidden = false
                } else {
                    self.errorView?.isHidden = true
                }
            }
        })
    }
    
    private func taps() {
        let tapFirst = UITapGestureRecognizer(target: self, action: #selector(selectFirstCurrency))
        selectFirstStackView?.addGestureRecognizer(tapFirst)
        
        let tapSecond = UITapGestureRecognizer(target: self, action: #selector(selectSecondCurrency))
        selectSecondStackView?.addGestureRecognizer(tapSecond)
    }

    @objc
    func selectFirstCurrency() {
        typeField = "firstTextField"
        goToBottomView()
    }
    
    @objc
    func selectSecondCurrency() {
        typeField = "secondTextField"
        goToBottomView()
    }
    
    private func goToBottomView() {
        let vc = BottomViewController(delegate: self, dataSource: self)
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func convert(_ sender: Any) {
        let value = Double(valueTextField?.text ?? "")
        resultLabel?.text = viewModel?.convertCurrencies(value: value ?? 0,
                                                         firstCurrency: quoteFirst ?? 0, for: quoteSecond ?? 0)
        resultLabel?.isHidden = false
        valueTextField?.resignFirstResponder()
    }
    @IBAction func tryAgain(_ sender: Any) {
        viewModel?.fetchQuotesCurrencies()
    }
}

extension ConvertViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel?.quotes.count ?? 0
    }
  
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel?.quotes[row].0
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if typeField == "firstTextField" {
            firstTextField?.text = viewModel?.quotes[row].0
            quoteFirst = viewModel?.quotes[row].1
        } else {
            secondTextField?.text = viewModel?.quotes[row].0
            quoteSecond = viewModel?.quotes[row].1
        }
    }
}
