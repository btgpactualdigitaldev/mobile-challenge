//
//  ViewController.swift
//  MobileChallenge
//
//  Created by Jonatas Coutinho de Faria on 03/11/20.
//

import UIKit

class ExchangeViewController: UIViewController {

    weak var coordinator: ExchangeViewControllerDelegate?
    
    var exchangeViewModel: ExchangeViewModel
    
    lazy var exchangeView: ExchangeView = {
        var view = ExchangeView(frame: self.view.frame)
        
        view.firstCurrencyButton.addTarget(self, action: #selector(didTappedOnButton(_:)), for: .touchUpInside)
        view.secondCurrencyButton.addTarget(self, action: #selector(didTappedOnButton(_:)), for: .touchUpInside)
        
        view.valueTextField.delegate = textFieldDelegate
        view.resultTextField.delegate = textFieldDelegate
        
        return view
    }()
    
    lazy var textFieldDelegate: TextFieldDelegate = {
        var delegate = TextFieldDelegate()
        delegate.changeTextFieldDelegate = self
        
        return delegate
    }()
    
    func fetchAllExchanges() {
        
        exchangeViewModel.fetchAllExchanges { [weak self] (result) in
            
            switch result {
            case .success(let exchanges):
                self?.exchangeViewModel.allExchanges = exchanges
                
            case .failure(let error):
                self?.showError(text: error.errorDescription)
            }
        }
    }
    
    func fetchSpecificExchanges(currencyCodes: [String]) {
        
        exchangeViewModel.fetchSpecificExchanges(currencyCodes: currencyCodes, completionHandler: { [weak self] (result) in
        
            switch result {
            case .success(let exchanges):
                
                DispatchQueue.main.async {
                    self?.exchangeViewModel.usedExchanges = exchanges
                    self?.updateResultLabel()
                }
                
            case .failure(let error):
                self?.showError(text: error.errorDescription)
            }
        })
    }
    
    func updateResultLabel(){
        let exchangeResult = exchangeViewModel.exchangeResult(value: exchangeView.valueTextField.text ?? "")
        
        exchangeView.resultTextField.text = String(exchangeResult)
    }
    
    func fetchExchangesInButtons(){
        let firstCurrency = exchangeView.firstCurrencyButton.titleLabel?.text ?? ""
        let secoundCurrency = exchangeView.secondCurrencyButton.titleLabel?.text ?? ""
        
        fetchSpecificExchanges(currencyCodes: [firstCurrency, secoundCurrency])
    }
    
    func receiveCoordinatorCallBack(currencyCode: String, callerButtonTag: Int){
        
        switch callerButtonTag {
        
        case exchangeView.firstCurrencyButton.tag:
            
            if exchangeViewModel.compareTitles(firstTitle: currencyCode, secondTitle: exchangeView.secondCurrencyButton.titleLabel?.text ?? "") {
                return
            }
            
            exchangeView.firstCurrencyButton.setTitle(currencyCode, for: .normal)
            
        case exchangeView.secondCurrencyButton.tag:
            
            if exchangeViewModel.compareTitles(firstTitle: currencyCode, secondTitle: exchangeView.firstCurrencyButton.titleLabel?.text ?? "") {
                return
            }
            
            exchangeView.secondCurrencyButton.setTitle(currencyCode, for: .normal)
            
        default:
            break
        }
        
        fetchExchangesInButtons()
    }
    
    func showError(text: String) {
        let alert = UIAlertController(title: text, message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
    @objc func didTappedOnButton(_ sender: Any){
        guard let button = sender as? UIButton else{
            return
        }
        
        coordinator?.goToCurrencies(callerButtonTag: button.tag)
    }
    
    func setUp() {
        self.title = "Exchange"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = exchangeView
        
        setUp()
        fetchExchangesInButtons()
    }
    
    init() {
        exchangeViewModel = ExchangeViewModel()
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ExchangeViewController: ChangeTextFieldDelegate {
    
    func didChangeText() {
        self.updateResultLabel()
    }
}

