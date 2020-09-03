//
//  CurrencyConversionViewController.swift
//  DesafioBTG
//
//  Created by Bittencourt Mantavani, Rômulo on 02/09/20.
//  Copyright © 2020 Bittencourt Mantovani, Rômulo. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CurrencyConversionViewController: UIViewController {
    // MARK: UI Components
    
    let containerView = UIView()
    let firstCurrencyLabelDescription = UILabel()
    let firstCurrencyTextFieldSelector = UITextField()
    let equalSignalImage = UIImageView()
    let secondCurrencyLabelDescription = UILabel()
    let secondCurrencyTextFieldSelector = UITextField()
    let firstButtonInvisible = UIButton()
    let secondButtonInvisible = UIButton()
    let firstButtonVisible = UIButton(type: .custom)
    let secondButtonVisible = UIButton(type: .custom)
    
    // MARK: Variables
    
    let viewModel = CurrencyConversionViewModel(withBusiness: CurrencyConverterBusinessModel())
    let disposeUIBag = DisposeBag()
    private var firstAppearing = true
    var firstCurrencyLabelDescriptionHeightConstraint: NSLayoutConstraint?
    var secondCurrencyLabelDescriptionHeightConstraint: NSLayoutConstraint?
    
    var firstCurrency: Currency?
    var secondCurrency: Currency?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        tap.cancelsTouchesInView = false

        view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if firstAppearing {
            self.setupUI()
            self.bindUI()
            self.firstAppearing = false
        }
        
        showObstructiveLoading()
        self.viewModel.rx_updateListValues().observeOn(MainScheduler.instance).subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            self.hideObstructiveLoading()
            self.firstCurrency = self.viewModel.getFirstCurrency()
            self.secondCurrency = self.viewModel.getSecondCurrency()
        }, onError: { error in
            //TO-DO: TRATAR ERRO
            self.hideObstructiveLoading()
        }).disposed(by: self.disposeUIBag)
    }
    
    // MARK: - Setup UI
    
    func setupUI() {
        setupNavigation()
        setupBackground()
        setupContainer()
        setupCurrencyFields()
        setupButtons()
        self.view.layoutIfNeeded()
    }
    
    private func fitViewYAxisToContainer(_ view: UIView) {
        view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: -24).isActive = true
        view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 24).isActive = true
    }
    
    private func setupDescriptionLabelLayout(_ label: UILabel) {
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textAlignment = .left
    }
    
    private func setupFieldLayout(_ field: UITextField) {
        field.font = UIFont.systemFont(ofSize: 16)
        field.textAlignment = .left
        field.placeholder = "Select a currency"
        field.borderStyle = .roundedRect//0, 97, 188
        field.tintColor = UIColor(red: 0.0, green: 97/255, blue: 188/255, alpha: 1.0)
        field.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.8)
        field.keyboardType = .numberPad
        field.isUserInteractionEnabled = false
    }
    
    private func setupNavigation() {
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 251/255,
                                                                           green: 160/255,
                                                                           blue: 40/255,
                                                                           alpha: 1.0)
        self.navigationController?.navigationBar.isOpaque = true
        let navImage = UIImageView(image: UIImage(named: "navigationImage"))
        
        navImage.widthAnchor.constraint(equalToConstant: (self.navigationController?.navigationBar.frame.size.height ?? 70) - 12).isActive = true
        navImage.heightAnchor.constraint(equalToConstant: (self.navigationController?.navigationBar.frame.size.height ?? 70) - 12).isActive = true
        navImage.contentMode = .scaleAspectFit
        
        self.navigationItem.titleView = navImage
    }
    
    func setupBackground() {
        self.view.backgroundColor = UIColor(red: 252/255,
                                            green: 227/255,
                                            blue: 116/255,
                                            alpha: 1.0)
    }
    
    func setupContainer() {
        self.view.addSubview(self.containerView)
        
        self.containerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        self.containerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.containerView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.666, constant: 0).isActive = true
        
        self.containerView.backgroundColor = .clear
        containerView.clipsToBounds = false
        
        self.containerView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupCurrencyFields() {
        self.containerView.addSubview(self.firstCurrencyLabelDescription)
        self.firstCurrencyLabelDescription.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        self.firstCurrencyLabelDescriptionHeightConstraint = self.firstCurrencyLabelDescription.heightAnchor.constraint(equalToConstant: 0)
        self.firstCurrencyLabelDescriptionHeightConstraint?.isActive = true
        self.fitViewYAxisToContainer(self.firstCurrencyLabelDescription)
        self.firstCurrencyLabelDescription.translatesAutoresizingMaskIntoConstraints = false
        self.setupDescriptionLabelLayout(firstCurrencyLabelDescription)
        
        self.containerView.addSubview(self.firstCurrencyTextFieldSelector)
        self.firstCurrencyTextFieldSelector.topAnchor.constraint(equalTo: firstCurrencyLabelDescription.bottomAnchor, constant: 2).isActive = true
        self.firstCurrencyTextFieldSelector.heightAnchor.constraint(equalToConstant: 60).isActive = true
        self.fitViewYAxisToContainer(self.firstCurrencyTextFieldSelector)
        self.firstCurrencyTextFieldSelector.translatesAutoresizingMaskIntoConstraints = false
        self.setupFieldLayout(firstCurrencyTextFieldSelector)
        
        self.containerView.addSubview(self.equalSignalImage)
        self.equalSignalImage.topAnchor.constraint(equalTo: firstCurrencyTextFieldSelector.bottomAnchor, constant: 24).isActive = true
        self.equalSignalImage.centerYAnchor.constraint(equalTo: self.containerView.centerYAnchor).isActive = true
        self.equalSignalImage.centerXAnchor.constraint(equalTo: self.containerView.centerXAnchor).isActive = true
        self.equalSignalImage.widthAnchor.constraint(equalToConstant: 30.0).isActive = true
        self.equalSignalImage.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        self.equalSignalImage.contentMode = .scaleAspectFit
        self.equalSignalImage.image = UIImage(named: "equalSignal")
        self.equalSignalImage.translatesAutoresizingMaskIntoConstraints = false
        
        self.containerView.addSubview(self.secondCurrencyLabelDescription)
        self.secondCurrencyLabelDescription.topAnchor.constraint(equalTo: equalSignalImage.bottomAnchor, constant: 24).isActive = true
        self.secondCurrencyLabelDescriptionHeightConstraint = self.secondCurrencyLabelDescription.heightAnchor.constraint(equalToConstant: 0)
        self.secondCurrencyLabelDescriptionHeightConstraint?.isActive = true
        self.fitViewYAxisToContainer(self.secondCurrencyLabelDescription)
        self.secondCurrencyLabelDescription.translatesAutoresizingMaskIntoConstraints = false
        self.setupDescriptionLabelLayout(secondCurrencyLabelDescription)
        
        self.containerView.addSubview(secondCurrencyTextFieldSelector)
        self.secondCurrencyTextFieldSelector.topAnchor.constraint(equalTo: secondCurrencyLabelDescription.bottomAnchor, constant: 2).isActive = true
        self.secondCurrencyTextFieldSelector.heightAnchor.constraint(equalToConstant: 60).isActive = true
        fitViewYAxisToContainer(secondCurrencyTextFieldSelector)
        self.secondCurrencyTextFieldSelector.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        self.secondCurrencyTextFieldSelector.translatesAutoresizingMaskIntoConstraints = false
        self.setupFieldLayout(secondCurrencyTextFieldSelector)
    }
    
    private func setupButtons() {
        self.containerView.addSubview(firstButtonInvisible)
        firstButtonInvisible.topAnchor.constraint(equalTo: self.containerView.topAnchor).isActive = true
        firstButtonInvisible.bottomAnchor.constraint(equalTo: self.firstCurrencyTextFieldSelector.bottomAnchor).isActive = true
        firstButtonInvisible.leadingAnchor.constraint(equalTo: self.firstCurrencyLabelDescription.leadingAnchor).isActive = true
        firstButtonInvisible.trailingAnchor.constraint(equalTo: self.firstCurrencyLabelDescription.trailingAnchor).isActive = true
        firstButtonInvisible.translatesAutoresizingMaskIntoConstraints = false
        self.containerView.bringSubviewToFront(firstButtonInvisible)
        
        self.containerView.addSubview(firstButtonVisible)
        firstButtonVisible.centerYAnchor.constraint(equalTo: firstCurrencyTextFieldSelector.centerYAnchor).isActive = true
        firstButtonVisible.heightAnchor.constraint(equalToConstant: 30).isActive = true
        firstButtonVisible.leadingAnchor.constraint(equalTo: self.firstCurrencyLabelDescription.trailingAnchor, constant: 8).isActive = true
        firstButtonVisible.widthAnchor.constraint(equalToConstant: 30).isActive = true
        let changeButtonImage = UIImage(named: "changeCurrencyIcon")
        
        firstButtonVisible.setBackgroundImage(changeButtonImage, for: .normal)
        firstButtonVisible.contentMode = .scaleAspectFit
        firstButtonVisible.isHidden = true
        firstButtonVisible.translatesAutoresizingMaskIntoConstraints = false
        self.containerView.bringSubviewToFront(firstButtonVisible)
        
        self.containerView.addSubview(secondButtonInvisible)
        secondButtonInvisible.topAnchor.constraint(equalTo: self.secondCurrencyLabelDescription.topAnchor).isActive = true
        secondButtonInvisible.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor).isActive = true
        secondButtonInvisible.leadingAnchor.constraint(equalTo: self.secondCurrencyLabelDescription.leadingAnchor).isActive = true
        secondButtonInvisible.trailingAnchor.constraint(equalTo: self.secondCurrencyLabelDescription.trailingAnchor).isActive = true
        secondButtonInvisible.translatesAutoresizingMaskIntoConstraints = false
        self.containerView.bringSubviewToFront(secondButtonInvisible)
        
        self.containerView.addSubview(secondButtonVisible)
        secondButtonVisible.centerYAnchor.constraint(equalTo: secondCurrencyTextFieldSelector.centerYAnchor).isActive = true
        secondButtonVisible.heightAnchor.constraint(equalToConstant: 30).isActive = true
        secondButtonVisible.leadingAnchor.constraint(equalTo: self.secondCurrencyLabelDescription.trailingAnchor, constant: 8).isActive = true
        secondButtonVisible.widthAnchor.constraint(equalToConstant: 30).isActive = true
        secondButtonVisible.setBackgroundImage(changeButtonImage, for: .normal)
        secondButtonVisible.contentMode = .scaleAspectFit
        secondButtonVisible.isHidden = true
        secondButtonVisible.translatesAutoresizingMaskIntoConstraints = false
        self.containerView.bringSubviewToFront(secondButtonVisible)
        
        firstButtonInvisible.setTitle(nil, for: .normal)
        secondButtonInvisible.setTitle(nil, for: .normal)
    }
    
    // MARK: - Bind UI
    
    func bindUI() {
        self.viewModel.rx_currencyChanged().subscribe {[weak self] event in
            guard let self = self, let selectedCurrencies = event.element else {return}
            self.firstCurrency = selectedCurrencies.0
            self.secondCurrency = selectedCurrencies.1
        }.disposed(by: self.disposeUIBag)
        
        self.firstCurrencyLabelDescription.rx.observe(String.self, "text")
            .distinctUntilChanged()
            .observeOn(MainScheduler.instance)
            .subscribe { [weak self] event in
                guard let text = event.element, let self = self else { return }
                
                let isEmpty = text?.isEmpty ?? true
                self.firstCurrencyLabelDescriptionHeightConstraint?.constant = isEmpty ? 0 : 30
                self.switchFirstButtonLayout(isEmpty: isEmpty)
                self.view.layoutIfNeeded()
        }.disposed(by: self.disposeUIBag)
        
        self.secondCurrencyLabelDescription.rx.observe(String.self, "text")
            .distinctUntilChanged()
            .observeOn(MainScheduler.instance)
            .subscribe { [weak self] event in
                guard let text = event.element, let self = self else { return }
                
                let isEmpty = text?.isEmpty ?? true
                self.secondCurrencyLabelDescriptionHeightConstraint?.constant = (isEmpty) ? 0 : 30
                self.switchSecondButtonLayout(isEmpty: isEmpty)
                self.view.layoutIfNeeded()
        }.disposed(by: self.disposeUIBag)
        
        self.firstButtonInvisible.addTarget(self, action: #selector(CurrencyConversionViewController.didTouchFirstButton(_:)), for: .touchUpInside)
        self.firstButtonVisible.addTarget(self, action: #selector(CurrencyConversionViewController.didTouchFirstButton(_:)), for: .touchUpInside)
        self.secondButtonInvisible.addTarget(self, action: #selector(CurrencyConversionViewController.didTouchSecondButton(_:)), for: .touchUpInside)
        self.secondButtonVisible.addTarget(self, action: #selector(CurrencyConversionViewController.didTouchSecondButton(_:)), for: .touchUpInside)
        
        self.firstCurrencyTextFieldSelector.rx.controlEvent(.editingChanged)
            .observeOn(MainScheduler.instance)
            .subscribe {[weak self] event in
                guard let self = self,
                    let text = self.firstCurrencyTextFieldSelector.text?.numbersOnly,
                    let doubleValue = Double(text),
                    let firstCurrency = self.firstCurrency else {return}
                self.firstCurrencyTextFieldSelector.text = doubleValue.formatCurrencyFrom(currencyCode: firstCurrency.code)
                self.recalculateValueForSecondCurrency()
        }.disposed(by: self.disposeUIBag)
        
        self.secondCurrencyTextFieldSelector.rx.controlEvent(.editingChanged)
            .observeOn(MainScheduler.instance)
            .subscribe {[weak self] event in
                guard let self = self,
                    let text = self.secondCurrencyTextFieldSelector.text?.numbersOnly,
                    let doubleValue = Double(text),
                    let secondCurrency = self.secondCurrency else {return}
                self.secondCurrencyTextFieldSelector.text = doubleValue.formatCurrencyFrom(currencyCode: secondCurrency.code)
                self.recalculateValueForFirstCurrency()
        }.disposed(by: self.disposeUIBag)
            
        
        self.viewModel.bindFirstCurrencyTo(label: self.firstCurrencyLabelDescription)
        self.viewModel.bindSecondCurrencyTo(label: self.secondCurrencyLabelDescription)
    }
    
    // MARK: - UI Methods
    
    func recalculateValueForFirstCurrency() {
        guard let secondCurrency = self.secondCurrency,
            let firstCurrency = self.firstCurrency,
            let secondText = self.secondCurrencyTextFieldSelector.text?.numbersOnly,
            let secondDouble = Double(secondText),
            let secondValueOfUSD = secondCurrency.valueOfUSD,
            let firstValueOfUSD = firstCurrency.valueOfUSD else {return}
        let secondFieldValueConverted = secondCurrency.isUSD  ? (secondDouble * firstValueOfUSD) : (secondDouble * firstValueOfUSD / secondValueOfUSD)
        self.firstCurrencyTextFieldSelector.text = secondFieldValueConverted.formatCurrencyFrom(currencyCode: firstCurrency.code)
    }
    
    func recalculateValueForSecondCurrency() {
        guard let secondCurrency = self.secondCurrency,
            let firstCurrency = self.firstCurrency,
            let firstText = self.firstCurrencyTextFieldSelector.text?.numbersOnly,
            let firstDouble = Double(firstText),
            let secondValueOfUSD = secondCurrency.valueOfUSD,
            let firstValueOfUSD = firstCurrency.valueOfUSD else {return}
        let firstFieldValueConverted = firstCurrency.isUSD  ? (firstDouble * secondValueOfUSD) : (firstDouble * secondValueOfUSD / firstValueOfUSD)
        self.secondCurrencyTextFieldSelector.text = firstFieldValueConverted.formatCurrencyFrom(currencyCode: secondCurrency.code)
    }
    
    @objc func didTouchFirstButton(_ sender: UIButton) {
        self.showCurrencySelector(forFirstCurrency: true)
    }
    
    @objc func didTouchSecondButton(_ sender: UIButton) {
        self.showCurrencySelector(forFirstCurrency: false)
    }
    
    func showCurrencySelector(forFirstCurrency: Bool) {
        let selectVC = CurrencySelectorViewController(nibName: nil, bundle: nil)
        selectVC.viewModel = CurrencySelectorViewModel(withBusiness: self.viewModel.businessWithProtocol(CurrencySelectorProtocol.self))
        selectVC.isSelectingFirstCurrency = forFirstCurrency
        var currenciesToIgnore: [Currency] = []
        if let currency = self.firstCurrency {
            currenciesToIgnore.append(currency)
        }
        if let currency = self.secondCurrency {
            currenciesToIgnore.append(currency)
        }
        selectVC.currenciesToIgnore = currenciesToIgnore
        let nav = selectVC.wrapedNavigation
        nav.modalPresentationStyle = .fullScreen
        
        self.present(nav, animated: true)
    }
    
    func switchFirstButtonLayout(isEmpty: Bool){
        self.firstButtonInvisible.isHidden = !isEmpty
        self.firstButtonVisible.isHidden = isEmpty
        firstCurrencyTextFieldSelector.isUserInteractionEnabled = !isEmpty
    }
    
    func switchSecondButtonLayout(isEmpty: Bool){
        self.secondButtonInvisible.isHidden = !isEmpty
        self.secondButtonVisible.isHidden = isEmpty
        secondCurrencyTextFieldSelector.isUserInteractionEnabled = !isEmpty
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.secondCurrencyTextFieldSelector.isFirstResponder && self.view.frame.origin.y == 0{
                let distanceFromFieldToBottom = self.view.frame.height - self.containerView.frame.maxY
                if keyboardSize.height + 8 > distanceFromFieldToBottom {
                    self.view.frame.origin.y -= (keyboardSize.height - distanceFromFieldToBottom) + 8
                }
            } else if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y = 0
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
