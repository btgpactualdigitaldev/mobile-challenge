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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        quotationView.chooseCurrencyView.originCurrencyButton.addTarget(self, action: #selector(makeRequest(sender:)), for: .touchUpInside)
        quotationView.chooseCurrencyView.destinyCurrencyButton.addTarget(self, action: #selector(makeRequest(sender:)), for: .touchUpInside)
    }
    
    @objc func makeRequest(sender: UIButton){
        switch sender.tag {
        case TagButton.origin.rawValue:
            coordinator?.showCurrencyList()
            viewModel.getCurrenciesQuotation { (result) in
                switch result {
                case .success(let currenciesQuotation):
                    self.coordinator?.currencyList?.didFinishFetchQuotations(currenciesQuotation: currenciesQuotation)
                case .failure(let error):
                    self.coordinator?.currencyList?.didFinishFetchQuotationsWithError(error: error)
                }
            }
        default:
            coordinator?.showCurrencyList()
        }
        
    }
}

