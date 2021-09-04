//
//  ConverterController.swift
//  CoinExchanger
//
//  Created by Edson Rottava on 03/09/21.
//

import UIKit

class ConverterController: UIViewController {
    let model = ConverterModel()
    var kb = false
    
    // MARK: View
    let contentView = ConverterView()
    
    // MARK: Override
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        fetchData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
}

private extension ConverterController {
    // MARK: Setup
    func setup() {
        view.backgroundColor = Asset.Colors.primary.color
        
        view.addSubview(contentView)
        contentView.fill(to: view)
        
        contentView.delegate = self
        contentView.visualDelegate = self
        
        model.fetchCompletion = fetchCompletion
    }
    
    func fetchData() {
        model.fetchCoins()
        model.fetchQuotes()
    }

    func tabCoin() {
        let mt = model.origin
        model.origin = model.target
        model.target = mt
        
        contentView.originConverter.button.setTitle(model.origin, for: .normal)
        contentView.targetConverter.button.setTitle(model.target, for: .normal)
        
        let t = contentView.originConverter.inputField.text
        contentView.originConverter.inputField.setText(contentView.targetConverter.inputField.text)
        contentView.targetConverter.inputField.setText(t)
    }
    
    func updateValue(_ text: String) {
        let value: Double = Double(text) ?? 0
        contentView.targetConverter.inputField.setText(model.appraise(value))
    }
    
    // MARK: Completion Handler
    func fetchCompletion() {
        contentView.originConverter.button.setTitle(model.origin, for: .normal)
        contentView.originConverter.inputField.currency = model.origin
        contentView.targetConverter.button.setTitle(model.target, for: .normal)
        contentView.targetConverter.inputField.currency = model.target
        contentView.footer.setTitle(L10n.Coin.Converter.date + " " + userPrefs.date, for: .normal)
        updateValue(Sanityze.number(contentView.originConverter.inputField.text ?? "0"))
    }
    
    func originCompletion(_ code: String?, _ name: String?) {
        model.origin = code ?? Constants.code
        contentView.originConverter.button.setTitle(model.origin, for: .normal)
        contentView.originConverter.inputField.currency = model.origin
    }
    
    func targetCompletion(_ code: String?, _ name: String?) {
        model.target = code ?? Constants.code
        contentView.targetConverter.button.setTitle(model.target, for: .normal)
        contentView.targetConverter.inputField.currency = model.target
    }
    
    // MARK: Keyboard
    func setKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if !kb {
                kb = true
                contentView.showKeyboard(with: keyboardSize.height+Helper.safeSize(for: .bottom))
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if kb {
            kb = false
            contentView.hideKeyboard()
        }
    }
}

// MARK: Generic Delegate
extension ConverterController: GenericDelegate {
    func didTouch(_ view: UIView) {
        switch view.tag {
        case 1:
            //present(CoinListController(originCompletion), animated: true)
            show(CoinListController(originCompletion), sender: self)
        case 2:
            //present(CoinListController(targetCompletion), animated: true)
            show(CoinListController(targetCompletion), sender: self)
        case 3:
            tabCoin()
        case 4:
            fetchData()
        default:
            break
        }
    }
}

// MARK: VisualInput Delegate
extension ConverterController: VisualInputDelegate {
    func didBeginEditing(_ input: VisualInput) { }
    
    func didChange(_ input: VisualInput) {
        switch input.tag {
        case 1:
            updateValue(Sanityze.number(input.text ?? "0"))
        default:
            break
        }
    }
    
    func didEndEditing(_ input: VisualInput, _ valid: Bool) { }
    
    func didReturn(_ input: VisualInput) { }
}
