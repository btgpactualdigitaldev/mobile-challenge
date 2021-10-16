//
//  ViewController.swift
//  btg-challenge
//
//  Created by Wesley Araujo on 13/09/20.
//  Copyright © 2020 Wesley Araujo. All rights reserved.
//

import UIKit

class ViewController: BaseViewController<MainViewModel> {
    
    
    @IBOutlet weak var currentCurrencyValueTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var sourceCurrencyButton: UIButton!
    @IBOutlet weak var destinyCurrencyButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentCurrencyValueTextField.delegate = self
        currentCurrencyValueTextField.addTarget(self, action: #selector(didChanged), for: .editingChanged)
        if let associatedViewModel = associetedViewModel { associatedViewModel.getQuotesCurrency() }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        associetedViewModel?.getSourceCurrencyButtonTitle()
    }
    
    func setResult(_ result: Double) {
        resultLabel.text = "\(result)"
    }
    
    func setButtonTitle(for sourceButtonTitle: String, destinyButtonTitle: String) {
        sourceCurrencyButton.setTitle(sourceButtonTitle, for: .normal)
        destinyCurrencyButton.setTitle(destinyButtonTitle, for: .normal)
    }
    
    @objc private func didChanged() {
        guard let text = currentCurrencyValueTextField.text else { return }
        if let value = Double(text) {
            associetedViewModel?.setResultToView(value: value)
        }
    }
    
    @IBAction func didPressOriginCurrencyButton(_ sender: UIButton) {
       if let controller = UIStoryboard(name: "CurrencySearchStoryboard", bundle: nil).instantiateViewController(withIdentifier: "CurrencySearchViewController") as? CurrencySearchViewController {
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true)
        
        }
    }
    
    
    @IBAction func didPressDestinyCurrencyButton(_ sender: Any) {
        if let controller = UIStoryboard(name: "CurrencySearchStoryboard", bundle: nil).instantiateViewController(withIdentifier: "CurrencySearchViewController") as? CurrencySearchViewController {
            controller.modalPresentationStyle = .fullScreen
            controller.isSourceCurrencyActionCaller = false
            self.present(controller, animated: true)
        }
    }
    
}

extension ViewController: UITextFieldDelegate {

}

