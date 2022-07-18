//
//  ConversionViewController.swift
//  CurrencyConverter
//
//  Created by Joao Jaco Santos Abreu on 25/09/21.
//

import UIKit

class ConversionViewController: UIViewController {
    
    weak var coordinator: ConversionCoordinator?
    var viewModel: ConversionViewModelProtocol
    var conversionView: ConversionView
    
    init(viewModel: ConversionViewModelProtocol) {
        self.viewModel = viewModel
        self.conversionView = ConversionView(viewModel: self.viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        conversionView.delegate = self
        view = conversionView
    }
    
}

    // MARK: - Extensions

extension ConversionViewController: ConversionViewDelegate {
    func didTapInitialCurrency() {
        coordinator?.didTapInitialCurrency(isInitial: true)
    }
    
    func didTapFinalCurrency() {
        coordinator?.didTapFinalCurrency(isInitial: false)
    }
    
    func didTapDoneButton() {
        view.endEditing(true)
    }
}

extension ConversionViewController: ConversionCoordinatorDelegate {
    func didSelectCurrency(currency: String, isInitial: Bool) {
        if isInitial {
            viewModel.onInitialCurrencyChange(currency: currency)
        } else {
            viewModel.onFinalCurrencyChange(currency: currency)
        }
    }
}
