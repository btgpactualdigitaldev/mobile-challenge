//
//  ConversionViewController.swift
//  DesafioBTG
//
//  Created by Robson Moreira on 17/02/20.
//  Copyright © 2020 Robson Moreira. All rights reserved.
//

import UIKit

class ConversionViewController: BaseViewController {

    @IBOutlet weak var sourceButton: UIButton!
    @IBOutlet weak var toButton: UIButton!
    @IBOutlet weak var reverseButton: UIButton!
    @IBOutlet weak var valueTextField: UITextField!
    @IBOutlet weak var converterButton: UIButton!
    @IBOutlet weak var convertedValueLabel: UILabel!
    @IBOutlet weak var convertedActivityIndicator: UIActivityIndicatorView!
    
    var sourceText: String?
    var toText: String?
    
    var interactor: ConversionBusinessDelegate!
    var router: (NSObjectProtocol & ConversionRoutingDelegate & ConversionDataPassing)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.interactor.setTextSourceButton()
        self.interactor.setTextToButton()
    }
    
    internal override func setup() {
        let viewController = self
        let interactor = ConversionInteractor()
        let presenter = ConversionPresenter()
        let router = ConversionRouter()
        
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = self.router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    private func setupView() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
        
        self.valueTextField.delegate = self
        
        self.convertedValueLabel.isHidden = true
        self.convertedActivityIndicator.isHidden = true
    }
    
    private func convertCurrency(currency: String, source: String, value: Double) {
        self.convertedValueLabel.isHidden = true
        self.convertedValueLabel.text = ""
        
        self.convertedActivityIndicator.startAnimating()
        self.convertedActivityIndicator.isHidden = false
        
        self.interactor.convertCurrency(request: Conversion.Quotes.Request(currency: currency, source: source, value: value))
    }
    
    func setupSourceButton(sourceText: String) {
        self.sourceButton.setTitle(sourceText, for: .normal)
        if let sourceFlag = IsoCountries.flag(currencyCode: sourceText) {
            self.sourceButton.setImage(sourceFlag.image(imageSize: 20), for: .normal)
        }
    }
    
    func setupToButton(toText: String) {
        self.toButton.setTitle(toText, for: .normal)
        if let toFlag = IsoCountries.flag(currencyCode: toText) {
            self.toButton.setImage(toFlag.image(imageSize: 20), for: .normal)
        }
    }
    
    @IBAction func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    @IBAction func reverseButtonTap(_ sender: UIButton) {
        self.view.endEditing(true)
        
        guard
            let sourceText = self.toText,
            let toText = self.sourceText,
            let value = valueTextField.text
            else { return }
        
        self.setupSourceButton(sourceText: sourceText)
        self.setupToButton(toText: toText)
        
        self.sourceText = sourceText
        self.toText = toText
        
        self.valueTextField.text = value.currencyInputFormatting(withCode: sourceText)
        
        self.convertCurrency(currency: toText, source: sourceText, value: value.toDouble())
    }
    
    @IBAction func converterButtonTap(_ sender: UIButton) {
        self.view.endEditing(true)
        
        guard
            let currency = self.toText,
            let source = self.sourceText,
            let value = valueTextField.text
            else { return }
        
        self.convertCurrency(currency: currency, source: source, value: value.toDouble())
    }
    
}
