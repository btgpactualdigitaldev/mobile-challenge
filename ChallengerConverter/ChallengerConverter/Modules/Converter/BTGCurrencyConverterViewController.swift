//
//  BTGCurrencyConverterViewController.swift
//  ChallengerConverter
//
//  Created by ADRIANO.MAZUCATO on 21/10/21.
//

import Foundation
import UIKit

class BTGCurrencyConverterViewController: BTGBaseViewController<BTGCurrencyConverterView> {
    
    let viewModel: BTGCurrencyConverterViewModel
    weak var coordinatorDelegate: BTGAppCoordinatorDelegate?
    
    init(viewModel: BTGCurrencyConverterViewModel, coordinatorDelegate: BTGAppCoordinatorDelegate?) {
        self.viewModel = viewModel
        self.coordinatorDelegate = coordinatorDelegate
        super.init()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTargets()
        bindViewModel()
        
        viewModel.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupNavigationBar()
        self.viewModel.updateConvertIfNecessary()
    }
}

fileprivate extension BTGCurrencyConverterViewController {
    func setupNavigationBar() {
        
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.tintColor = AppStyle.Color.navigationTint
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: AppStyle.Color.navigationTitleColor]
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: AppStyle.Color.navigationTitleColor]
        title = "Conversor"
    }
    
    func addTargets() {
        mainView.buttonFrom.addTarget(self, action: #selector(showFromPickerCurrencies), for: .touchUpInside)
        mainView.buttonTo.addTarget(self, action: #selector(showToPickerCurrencies), for: .touchUpInside)
        
        mainView.numberTextField.didUpdateValue = { [unowned self] val in
            viewModel.currentValue = val
        }
        
    }
    
    func bindViewModel() {
        viewModel.didShowConvertedValue = { [unowned self] value in
            self.mainView.currencyConverterLabel.text = value
        }
        
        viewModel.didShowError = { [unowned self] error in
            self.showAlert(error)
        }
        
        viewModel.didShowErrorWithReload = { [unowned self] error in
            self.showAlert("Ops", error, "Recarregar") {
                self.viewModel.fetchQuotes()
            }
        }
        
        viewModel.didUpdateFromCurrency = { [unowned self] code in
            self.mainView.buttonFrom.setTitle(code, for: .normal)
            self.mainView.numberTextField.currencyCode = code
        }
        
        viewModel.didUpdateToCurrency = { [unowned self] code in
            self.mainView.buttonTo.setTitle(code, for: .normal)
        }
        
        viewModel.didEnableEdiValeu = { [unowned self] enable in
            self.mainView.numberTextField.isEnabled = enable
            self.mainView.numberTextField.isHidden = !enable
        }
        
        viewModel.didShowSpinner = { [unowned self] showSpinner in
            if(showSpinner) {
                self.mainView.showSpinner()
            } else {
                self.mainView.hideSpinner()
            }
        }
        viewModel.didWantEditCurrency = { [unowned self] in
            self.coordinatorDelegate?.showPickerCurrencies()
        }
    }
}

extension BTGCurrencyConverterViewController {
    @objc private func showFromPickerCurrencies() {
        viewModel.showPickSupporteds(type: .from)
    }

    @objc private func showToPickerCurrencies() {
        viewModel.showPickSupporteds(type: .to)
    }
}
