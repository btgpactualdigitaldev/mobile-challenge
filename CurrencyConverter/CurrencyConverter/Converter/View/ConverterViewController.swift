//
//  ConverterViewController.swift
//  CurrencyConverter
//
//  Created by Breno Aquino on 29/10/20.
//

import UIKit

class ConverterViewController: UIViewController, StateTransition {
    
    private let viewModel: ConverterViewModel = ConverterViewModel()
    var loadingView: UIView = LoadingView()
    
    // MARK: - Layout Vars
    private lazy var originCurrencyButton: UIButton = {
        let button = UIButton().cornerRadius(Style.defaultRadius).useConstraint()
        button.titleLabel?.numberOfLines = 2
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(originList), for: .touchUpInside)
        button.setBackgroundColor(color: Style.veryDarkGray, forState: .normal)
        return button
    }()
    
    private lazy var targetCurrencyButton: UIButton = {
        let button = UIButton().cornerRadius(Style.defaultRadius).useConstraint()
        button.titleLabel?.numberOfLines = 2
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(targetList), for: .touchUpInside)
        button.setBackgroundColor(color: Style.veryDarkGray, forState: .normal)
        return button
    }()
    
    private lazy var converterView: CurrencyConverterView = {
        let converterView = CurrencyConverterView().cornerRadius(Style.defaultRadius).useConstraint()
        converterView.backgroundColor = Style.veryDarkGray
        converterView.delegate = self
        return converterView
    }()
    
    private lazy var emptyCurrencyView: EmptyCurrencyView = {
        let emptyCurrencyView = EmptyCurrencyView().useConstraint()
        emptyCurrencyView.delegate = self
        return emptyCurrencyView
    }()
    
    private lazy var infoLable: UILabel = {
        let label = UILabel().useConstraint()
        label.textColor = Style.defaultSecondaryTextColor
        label.font = Style.defaultFont
        return label
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        viewModel.delegate = self
    }
    
    // MARK: - Setups
    private func setupLayout() {
        view.backgroundColor = .black
        view.addSubview(originCurrencyButton)
        view.addSubview(targetCurrencyButton)
        view.addSubview(converterView)
        view.addSubview(emptyCurrencyView)
        view.addSubview(infoLable)
        
        originCurrencyButton
            .top(anchor: view.safeAreaLayoutGuide.topAnchor, constant: Style.defaultTop)
            .leading(anchor: view.leadingAnchor, constant: Style.defaultLeading)
            .height(constant: Style.Home.currencyHeight)
            .width(anchor: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.5, constant: Style.Home.widthOffset)
        
        targetCurrencyButton
            .top(anchor: view.safeAreaLayoutGuide.topAnchor, constant: Style.defaultTop)
            .trailing(anchor: view.trailingAnchor, constant: Style.defaultTrailing)
            .height(constant: Style.Home.currencyHeight)
            .width(anchor: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.5, constant: Style.Home.widthOffset)
        
        converterView
            .top(anchor: targetCurrencyButton.bottomAnchor, constant: Style.defaultTop)
            .leading(anchor: view.leadingAnchor, constant: Style.defaultLeading)
            .trailing(anchor: view.trailingAnchor, constant: Style.defaultTrailing)
        
        infoLable
            .top(anchor: converterView.bottomAnchor, constant: Style.defaultCloseTop)
            .leading(anchor: view.leadingAnchor, constant: Style.defaultLeading)
            .trailing(anchor: view.trailingAnchor, constant: Style.defaultTrailing)
        
        emptyCurrencyView
            .top(anchor: view.safeAreaLayoutGuide.topAnchor, constant: Style.defaultTop)
            .leading(anchor: view.leadingAnchor, constant: Style.defaultLeading)
            .trailing(anchor: view.trailingAnchor, constant: Style.defaultTrailing)
            .bottom(anchor: view.bottomAnchor)
    }
    
    private func createAttributedString(code: String, name: String) -> NSMutableAttributedString {
        let titleAttributed: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white, .font: Style.defaultFont]
        let subtitleAttributed: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.lightGray, .font: Style.defaultFont]
        let string = NSMutableAttributedString(string: "\(code)\n", attributes: titleAttributed)
        string.append(NSAttributedString(string: "\(name)", attributes: subtitleAttributed))
        return string
    }
    
    // MARK: - Actions
    @objc private func originList() {
        let controller = ListViewController(type: .origin)
        controller.delegate = self
        present(UINavigationController(rootViewController: controller), animated: true)
    }
    
    @objc private func targetList() {
        let controller = ListViewController(type: .target)
        controller.delegate = self
        present(UINavigationController(rootViewController: controller), animated: true)
    }
}

// MARK: - ConverterView Delegate
extension ConverterViewController: CurrencyConverterViewDelegate {
    func textFormatting(_ text: String?) -> (input: String, output: String) {
        let input: String = viewModel.textValueFomatter(text)
        let output: String = viewModel.conversor(value: Double(input) ?? 0)
        return (input, output)
    }
}

// MARK: - EmptyView Delegate
extension ConverterViewController: EmptyCurrencyViewDelegate {
    func didClickToOpenList(type: CurrencyType) {
        switch type {
        case .origin:
            originList()
        case .target:
            targetList()
        }
    }
}

// MARK: - ViewModel
extension ConverterViewController: ConverterViewModelDelegate {
    func setCurrency(_ currency: Currecy, type: CurrencyType) {
        let title = createAttributedString(code: currency.code, name: currency.name)
        converterView.setupCurrency(currency, type: type)
        emptyCurrencyView.setupCurrency(currency, type: type, title: title)
        emptyCurrencyView.isHidden = viewModel.isReadyForConversion
        
        switch type {
        case .origin:
            originCurrencyButton.setAttributedTitle(title, for: .normal)
        case .target:
            targetCurrencyButton.setAttributedTitle(title, for: .normal)
        }
    }
    
    func onLoading() {
        loading()
    }
    
    func onSetCurrencySuccess() {
        DispatchQueue.main.async { [weak self] in
            self?.infoLable.text = self?.viewModel.lastUpdate
            self?.content()
        }
    }
    
    func onError(_ error: String) {
        DispatchQueue.main.async { [weak self] in
            self?.infoLable.text = error
            self?.content()
        }
    }
}

// MARK: - List Delegate
extension ConverterViewController: ListDelegate {
    func didSelectCurrency(_ currency: Currecy, type: CurrencyType) {
        viewModel.setCurrency(currency, type: type)
    }
}
