//
//  ExchangeViewController.swift
//  CurrencyExchange
//
//  Created by Carlos Fontes on 29/10/20.
//

import UIKit

protocol ExchangeViewControllerDelegate: class {
    func presentCurrencyListWithButtonType(_ type: CurrencyButtonType)
}

enum CurrencyButtonType {
    case origin, destination
}

class ExchangeViewController: UIViewController {
    
    // MARK: - Properties
    
    weak var coordinator: ExchangeViewControllerDelegate?
    
    var viewModel: ExchangeViewModel
    
    private let exchangeView: ExchangeView = {
        let view = ExchangeView(frame: .zero)
        return view
    }()
    
    init(viewModel: ExchangeViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.exchangeView.originCurrencyButton.addTarget(self, action: #selector(tappedOnOriginButton), for: .touchUpInside)
        
        self.exchangeView.destinationCurrencyButton.addTarget(self, action: #selector(tappedOnDestinationButton), for: .touchUpInside)
        self.hideKeyboardWhenTappedAround()

    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        self.view = exchangeView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationController()
    }

    // MARK: - Selectors
    
    @objc func tappedOnOriginButton(){        
        self.coordinator?.presentCurrencyListWithButtonType(.origin)
    }
    
    @objc func tappedOnDestinationButton(){
        self.coordinator?.presentCurrencyListWithButtonType(.destination)
    }
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
