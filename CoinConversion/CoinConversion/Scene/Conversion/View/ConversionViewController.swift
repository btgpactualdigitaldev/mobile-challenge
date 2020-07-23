//
//  ConversionViewController.swift
//  CoinConversion
//
//  Created by Ronilson Batista on 18/07/20.
//  Copyright © 2020 Ronilson Batista. All rights reserved.
//

import UIKit

// MARK: - Main
class ConversionViewController: UIViewController {
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var updateDateLabel: UILabel!
    @IBOutlet private weak var fromCurrencyNameLabel: UILabel!
    @IBOutlet private weak var fromCurrencyCodeLabel: UILabel!
    
    @IBOutlet private weak var valueTextField: UITextField! {
        didSet {
            valueTextField.delegate = self
            valueTextField.tintColor = .colorDarkishPink
            valueTextField.keyboardType = .numberPad
        }
    }
    
    @IBOutlet private weak var fromView: UIView! {
        didSet {
            fromView.setCardLayout()
            fromViewTapGestureRecognizer(fromView)
        }
    }
    
    @IBOutlet private weak var fromWithCurrencyView: UIView! {
        didSet {
            fromWithCurrencyView.isHidden = true
            fromWithCurrencyView.setCardLayout()
            fromViewTapGestureRecognizer(fromWithCurrencyView)
        }
    }
    
    @IBOutlet private weak var fromSeparatorView: UIView! {
        didSet {
            fromSeparatorView.backgroundColor = .colorGrayLighten60
        }
    }
    
    @IBOutlet private weak var toCurrencyNameLabel: UILabel!
    @IBOutlet private weak var toCurrencyCodeLabel: UILabel!
    
    @IBOutlet private weak var toView: UIView! {
        didSet {
            toView.setCardLayout()
            toViewTapGestureRecognizer(toView)
        }
    }
    
    @IBOutlet private weak var toWithCurrencyView: UIView! {
        didSet {
            toWithCurrencyView.isHidden = true
            toWithCurrencyView.setCardLayout()
            toViewTapGestureRecognizer(toWithCurrencyView)
        }
    }
    
    @IBOutlet private weak var toSeparatorView: UIView! {
        didSet {
            toSeparatorView.backgroundColor = .colorGrayLighten60
        }
    }
    
    @IBOutlet private weak var conversionStackView: UIStackView! {
        didSet {
            conversionStackView.isHidden = true
        }
    }
    
    @IBOutlet private weak var valueView: UIView! {
        didSet {
            valueView.setCardLayout()
        }
    }
    
    @IBOutlet private weak var resultView: UIView! {
        didSet {
            resultView.setCardLayout()
        }
    }
    
    @IBOutlet private weak var resultLabel: UILabel!
    
    var viewModel: ConversionViewModel?
    
    private var currentString = ""
    
    init(viewModel: ConversionViewModel) {
        self.viewModel = viewModel
        super.init(nibName: ConversionViewController.nibName, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UIViewController lifecycle
extension ConversionViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .colorBackground
        
        setupNavigationBar()
        setupBarButton()
        addDoneButtonOnKeyboard()
        
        viewModel?.delegate = self
        viewModel?.fetchQuotes(isRefresh: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - Private methods
extension ConversionViewController {
    private func setupNavigationBar() {
        configureNavigationBar(largeTitleColor: .white,
                               backgoundColor: .colorDarkishPink,
                               tintColor: .white,
                               title: "Conversão",
                               preferredLargeTitle: true,
                               isSearch: false,
                               searchController: nil
        )
    }
    
    private func setupBarButton() {
        let button = UIBarButtonItem(
            barButtonSystemItem: .refresh,
            target: self,
            action: #selector(self.refreshButtonTouched)
        )
        button.tintColor = .white
        navigationItem.rightBarButtonItem = button
    }
    
    @objc private dynamic func refreshButtonTouched() {
        viewModel?.fetchQuotes(isRefresh: true)
    }
    
    private func doLoading(action: UIAlertAction) {
        viewModel?.fetchQuotes(isRefresh: true)
    }
    
    private func toViewTapGestureRecognizer(_ view: UIView) {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureRecognizedToView(sender:)))
        view.addGestureRecognizer(gesture)
    }
    
    private func fromViewTapGestureRecognizer(_ view: UIView) {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureRecognizedFromView(sender:)))
        view.addGestureRecognizer(gesture)
    }
    
    @objc private dynamic func tapGestureRecognizedToView(sender: UITapGestureRecognizer) {
        viewModel?.fetchCurrencies(.to)
    }
    
    @objc private dynamic func tapGestureRecognizedFromView(sender: UITapGestureRecognizer) {
        viewModel?.fetchCurrencies(.from)
    }
    
    @objc private func keyboardWillShow(notification:NSNotification){
        guard let userInfo = notification.userInfo else {
            return
        }
        
        var keyboardFrame:CGRect = (
            userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue
            ).cgRectValue
        keyboardFrame = view.convert(keyboardFrame, from: nil)
        
        var contentInset: UIEdgeInsets = scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height
        scrollView.contentInset = contentInset
    }
    
    @objc private func keyboardWillHide(notification:NSNotification){
        let contentInset: UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }
    
    private func addDoneButtonOnKeyboard(){
        let doneToolbar: UIToolbar = UIToolbar(
            frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50)
        )
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        let done: UIBarButtonItem = UIBarButtonItem(
            title: "Done",
            style: .done,
            target: self,
            action: #selector(self.doneButtonAction)
        )
        done.title = "Ok"
        done.tintColor = .colorDarkishPink
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        valueTextField.inputAccessoryView = doneToolbar
    }
    
    @objc private func doneButtonAction(){
        valueTextField.resignFirstResponder()
    }
}
// MARK: - UITextFieldDelegate
extension ConversionViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let fromCode = fromCurrencyCodeLabel.text,
            let toCode = toCurrencyCodeLabel.text  else {
                return true
        }
        
        if (textField.text!.count <= 30 && string == "") || (textField.text!.count < 30 && string != "") {
            switch string {
            case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9":
                currentString += string
                formatCurrency(currentString, textField: textField, currencyCode: fromCode)
            default:
                if string.count == 0 && currentString.count != 0 {
                    currentString = String(currentString.dropLast())
                    formatCurrency(currentString, textField: textField, currencyCode: fromCode)
                }
            }
        }
        viewModel?.fetchConvert(fromCode: fromCode, toCode: toCode, value: currentString)
        return false
    }
}


// MARK: - Format Currency
extension ConversionViewController {
    private func formatCurrency(_ string: String, textField: UITextField, currencyCode: String) {
        textField.text = viewModel?.formatCurrency(currencyCode: currencyCode, amount: string)!
    }
}

// MARK: - ConversionViewModelDelegate
extension ConversionViewController: ConversionViewModelDelegate {
    func didStartLoading() {
        showActivityIndicator()
    }
    
    func didHideLoading() {
        hideActivityIndicator()
    }
    
    func didReloadData(code: String, name: String, conversion: Conversion) {
        switch conversion {
        case .from:
            fromView.isHidden = true
            fromWithCurrencyView.isHidden = false
            fromCurrencyNameLabel.text = name
            fromCurrencyCodeLabel.text = code
        case .to:
            toView.isHidden = true
            toWithCurrencyView.isHidden = false
            toCurrencyCodeLabel.text = code
            toCurrencyNameLabel.text = name
        }
        
        if fromView.isHidden && toView.isHidden {
            conversionStackView.isHidden = false
        }
        resultLabel.text = "-"
        resultView.setCardLayout()
        valueTextField.text = ""
        currentString = ""
    }
    
    func didReloadResult(with value: String, color: UIColor) {
        resultLabel.text = value
        resultView.setCardLayout(color)
    }
    
    func didUpdateDate(with date: String) {
        updateDateLabel.text = date
    }
    
    func didFail(with title: String, message: String, buttonTitle: String, noConnection: Bool, dataSave: Bool) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        if noConnection && !dataSave {
            alert.addAction(UIAlertAction(title: buttonTitle, style: .cancel, handler: doLoading))
        } else {
            alert.addAction(UIAlertAction(title: buttonTitle, style: .cancel, handler: nil))
        }
        present(alert, animated: true, completion: nil)
    }
}
