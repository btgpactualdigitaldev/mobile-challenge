//
//  CurrencyConverterViewController.swift
//  iOSBTG
//
//  Created by Filipe Merli on 08/06/20.
//  Copyright © 2020 Filipe Merli. All rights reserved.
//

import UIKit

protocol CurrencyConverterDisplayLogic: class {
    func renderConvertion(viewModel: CurrencyConverter.Fetch.ViewModel)
    func showEmptyState()
}

final class CurrencyConverterViewController: UIViewController {
    
    // MARK:  Properties
        
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        indicator.style = .gray
        return indicator
    }()
    
    private lazy var emptyView: EmptyStateView = {
        let empty = EmptyStateView()
        empty.translatesAutoresizingMaskIntoConstraints = false
        return empty
    }()
    
    private lazy var containerView: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    private lazy var sourceCurrency: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.showsSelectionIndicator = true
        picker.tag = 0
        picker.backgroundColor = .groupTableViewBackground
        picker.layer.cornerRadius = 10
        picker.layer.masksToBounds = true
        return picker
    }()
    
    private lazy var convertedCurrency: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.showsSelectionIndicator = true
        picker.backgroundColor = .groupTableViewBackground
        picker.tag = 1
        picker.layer.cornerRadius = 10
        picker.layer.masksToBounds = true
        return picker
    }()
    
    private lazy var sourceValue: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.text = "1.00"
        field.textAlignment = .center
        field.borderStyle = .roundedRect
        field.keyboardType = .decimalPad
        return field
    }()
    
    private lazy var convertedValue: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.text = "0.0"
        field.textAlignment = .center
        field.borderStyle = .roundedRect
        field.isUserInteractionEnabled = false
        return field
    }()
    
    private lazy var sourceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Origem"
        label.textAlignment = .center
        return label
    }()
    
    private lazy var convertedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Destino"
        label.textAlignment = .center
        return label
    }()
        
    var interactor: CurrencyConverterBusinessLogic?
    var router: (NSObjectProtocol & CurrencyConverterRoutingLogic)?
    private var sourceRequest = "USD"
    private var viewModel: CurrencyConverter.Fetch.ViewModel?
    private var firstValue: Float32 = 1.0
    private var secondValue: Float32 = 0.0
    private var sourceCurrencyIndex = 0
        
    private(set) var viewState: ViewState = .loading {
        didSet {
            switch viewState {
            case .loaded:
                DispatchQueue.main.async {
                    self.loadingIndicator.stopAnimating()
                    self.containerView.alpha = 1.0
                }
                break
            case .loading:
                DispatchQueue.main.async {
                    self.loadingIndicator.startAnimating()
                    self.emptyView.alpha = 0.0
                    self.containerView.alpha = 0.0
                }
                break
            case .empty:
                DispatchQueue.main.async {
                    self.loadingIndicator.stopAnimating()
                    self.emptyView.alpha = 1.0
                }
                break
            }
        }
    }
    
    // MARK: Initializers
    
    init(configurator: CurrencyConverterConfigurator = CurrencyConverterConfigurator.shared) {
        super.init(nibName: nil, bundle: nil)
        configurator.configure(viewController: self)
        setUpSubViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        CurrencyConverterConfigurator.shared.configure(viewController: self)
    }
    
    // MARK: ViewController life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sourceCurrency.delegate = self
        sourceCurrency.dataSource = self
        convertedCurrency.delegate = self
        convertedCurrency.dataSource = self
        view.backgroundColor = .white
        self.hideKeyboardWhenTappedAround()
        sourceValue.addTarget(self, action: #selector(valueTextChanged), for: .editingDidEnd)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if viewState != .loaded {
            viewState = .loading
        }
        if viewModel == nil {
            interactor?.fetchGetCurrencies(request: CurrencyConverter.Fetch.Request(source: sourceRequest))
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let navTopItem = navigationController?.navigationBar.topItem {
            navTopItem.titleView = .none
            navTopItem.title = "Converter"
        }
    }
    
    // MARK: Class Funcitons
    
    private func setUpSubViews() {
        view.addSubview(loadingIndicator)
        view.addSubview(emptyView)
        view.addSubview(containerView)
        containerView.addSubview(sourceLabel)
        containerView.addSubview(convertedLabel)
        containerView.addSubview(sourceCurrency)
        containerView.addSubview(convertedCurrency)
        containerView.addSubview(sourceValue)
        containerView.addSubview(convertedValue)
        NSLayoutConstraint.activate([
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.widthAnchor.constraint(equalToConstant: 35.0),
            loadingIndicator.heightAnchor.constraint(equalToConstant: 35.0),
            emptyView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyView.widthAnchor.constraint(equalTo: view.widthAnchor),
            emptyView.heightAnchor.constraint(equalTo: view.heightAnchor),
            containerView.heightAnchor.constraint(equalToConstant: (view.bounds.height * 0.5)),
            containerView.widthAnchor.constraint(equalToConstant: (view.bounds.width * 0.8)),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -25),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sourceCurrency.bottomAnchor.constraint(equalTo: containerView.centerYAnchor, constant: -10),
            sourceCurrency.trailingAnchor.constraint(equalTo: containerView.centerXAnchor, constant: -20),
            sourceCurrency.widthAnchor.constraint(equalToConstant: 100),
            sourceCurrency.heightAnchor.constraint(equalToConstant: 100),
            convertedCurrency.bottomAnchor.constraint(equalTo: containerView.centerYAnchor, constant: -10),
            convertedCurrency.leadingAnchor.constraint(equalTo: containerView.centerXAnchor, constant: 20),
            convertedCurrency.widthAnchor.constraint(equalToConstant: 100),
            convertedCurrency.heightAnchor.constraint(equalToConstant: 100),
            sourceLabel.bottomAnchor.constraint(equalTo: sourceCurrency.topAnchor, constant: 0),
            sourceLabel.trailingAnchor.constraint(equalTo: containerView.centerXAnchor, constant: -20),
            sourceLabel.widthAnchor.constraint(equalToConstant: 100),
            sourceLabel.heightAnchor.constraint(equalToConstant: 55),
            convertedLabel.bottomAnchor.constraint(equalTo: convertedCurrency.topAnchor, constant: 0),
            convertedLabel.leadingAnchor.constraint(equalTo: containerView.centerXAnchor, constant: 20),
            convertedLabel.widthAnchor.constraint(equalToConstant: 100),
            convertedLabel.heightAnchor.constraint(equalToConstant: 55),
            sourceValue.topAnchor.constraint(equalTo: containerView.centerYAnchor, constant: 10),
            sourceValue.trailingAnchor.constraint(equalTo: containerView.centerXAnchor, constant: -20),
            sourceValue.widthAnchor.constraint(equalToConstant: 100),
            sourceValue.heightAnchor.constraint(equalToConstant: 50),
            convertedValue.topAnchor.constraint(equalTo: containerView.centerYAnchor, constant: 10),
            convertedValue.leadingAnchor.constraint(equalTo: containerView.centerXAnchor, constant: 20),
            convertedValue.widthAnchor.constraint(equalToConstant: 100),
            convertedValue.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func showFinalValue() {
        guard let sourceText = sourceValue.text else { return }
        guard let sourceFloat = Float32(sourceText) else {
            showErrorAlert(with: "Entrada inválida. (Exemplo válido 1.0)")
            return
        }
        if sourceCurrency.selectedRow(inComponent: 0) == convertedCurrency.selectedRow(inComponent: 0) {
            convertedValue.text = "\(sourceFloat)"
            return
        } else if viewModel?.sourceIndex == sourceCurrency.selectedRow(inComponent: 0) {
            firstValue = sourceFloat
        } else {
            let index = sourceCurrency.selectedRow(inComponent: 0)
            guard let sourceVal =  viewModel?.orderedValues[index] else {
                return
            }
            firstValue = (1.0 / sourceVal) * sourceFloat
        }
        convertedValue.text = "\(firstValue * secondValue)"
    }
    
    @objc private func valueTextChanged() {
        showFinalValue()
    }

}

// MARK: - CurrencyConverterListDisplayLogic

extension CurrencyConverterViewController: CurrencyConverterDisplayLogic {
    
    func renderConvertion(viewModel: CurrencyConverter.Fetch.ViewModel) {
        self.viewModel = viewModel
        guard viewModel.orderedQuotes.count > 0 else { return }
        DispatchQueue.main.async {
            self.sourceCurrency.reloadAllComponents()
            self.convertedCurrency.reloadAllComponents()
            self.sourceCurrency.selectRow(viewModel.sourceIndex, inComponent: 0, animated: true)
            self.convertedCurrency.selectRow(viewModel.sourceIndex, inComponent: 0, animated: true)
        }
        viewState = .loaded
        DispatchQueue.main.async {
            self.showFinalValue()
        }
    }
    
    func showEmptyState() {
        viewState = .empty
    }
    
}

// MARK: - UIPickerViewDelegate

extension CurrencyConverterViewController: UIPickerViewDelegate {

}

// MARK: - UIPickerViewDataSource

extension CurrencyConverterViewController: UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel?.orderedQuotes.count ?? 0
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel?.orderedQuotes[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let values = viewModel?.orderedValues else { return }
        if pickerView.tag == 0 {
            sourceCurrencyIndex = row
        } else {
            secondValue = values[row]
        }
        showFinalValue()
        
    }

}
