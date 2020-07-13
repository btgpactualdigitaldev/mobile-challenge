//
//  HomeController.swift
//  ConverterCurrencyBTG
//
//  Created by Thiago Vaz on 30/06/20.
//  Copyright © 2020 Thiago Santos. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    let viewTo: CurrencyView = CurrencyView.instanceFromNib()
    let viewFrom: CurrencyView = CurrencyView.instanceFromNib()
    
    let titleDescription: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Quero converter"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    lazy var amountTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        textField.placeholder = "Digite o valor"
        return textField
    }()
    
    let resultLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        return label
    }()
    
    lazy var buttonConvert: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Converte", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(send), for: .touchUpInside)
        return button
    }()
    
    var presenter: HomePresenterInput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        presenter.viewDidLoad()
    }
    
    @objc func send() {
        guard let amountText = amountTextField.text,  let amountDecimal = Decimal.fromString(amountText) else {
            return
        }
        presenter.send(amount: amountDecimal)
    }
    
    func setupLayout() {
        title = "Conversão de moeda"
        
        let gestureTo:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(targetViewDidTappedTo(_:)))
        let gestureFrom:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(targetViewDidTappedFrom(_:)))
        viewTo.translatesAutoresizingMaskIntoConstraints = false
        viewFrom.translatesAutoresizingMaskIntoConstraints = false
        viewTo.tag = 0
        viewFrom.tag = 1
        viewTo.addGestureRecognizer(gestureTo)
        viewFrom.addGestureRecognizer(gestureFrom)
        view.addSubview(viewTo)
        view.addSubview(viewFrom)
        view.addSubview(titleDescription)
        view.addSubview(amountTextField)
        view.addSubview(resultLabel)
        view.addSubview(buttonConvert)
        let width = (view.frame.width / 2) - 16
        NSLayoutConstraint.activate([
            viewTo.widthAnchor.constraint(equalToConstant: width),
            viewTo.heightAnchor.constraint(equalToConstant: 100),
            viewTo.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            viewTo.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewFrom.topAnchor.constraint(equalTo: viewTo.topAnchor),
            viewFrom.leadingAnchor.constraint(equalTo: viewTo.trailingAnchor, constant: 4),
            viewFrom.heightAnchor.constraint(equalTo: viewTo.heightAnchor),
            viewFrom.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -4),
            titleDescription.topAnchor.constraint(equalTo: viewTo.bottomAnchor, constant: 15),
            titleDescription.leadingAnchor.constraint(equalTo: viewTo.leadingAnchor, constant: 16),
            amountTextField.topAnchor.constraint(equalTo: titleDescription.topAnchor),
            amountTextField.widthAnchor.constraint(equalToConstant: width),
            amountTextField.leadingAnchor.constraint(equalTo: titleDescription.trailingAnchor, constant: 8),
            amountTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            buttonConvert.topAnchor.constraint(equalTo: titleDescription.bottomAnchor, constant: 20),
            buttonConvert.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            buttonConvert.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            buttonConvert.heightAnchor.constraint(equalToConstant: 40),
            resultLabel.topAnchor.constraint(equalTo: buttonConvert.bottomAnchor, constant: 20),
            resultLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            resultLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
    }
    
    @objc func targetViewDidTappedTo(_ sender: UITapGestureRecognizer) {
        presenter.changeCurrency(currency: .to)
    }
    
    @objc func targetViewDidTappedFrom(_ sender: UITapGestureRecognizer) {
        presenter.changeCurrency(currency: .from)
    }
    override func retry(){
        presenter.tryAgain()
    }
}

extension HomeController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == amountTextField {
            resultLabel.text = ""
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let finalText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string).trimmingCharacters(in: .whitespacesAndNewlines) {
            textField.text = finalText.toCurrency()
        }
        return false
    }
}

extension HomeController: HomePresenterOutput {
    
    func loading() {
        isActiveElement(isActive: true)
        setEmptyView(title:"Carregando", message: "Buscando dados", isLoading: true, image: #imageLiteral(resourceName: "loading_imgBlue_78x78"))
    }
    
    func error(viewModel: ErrorViewModel) {
        isActiveElement(isActive: true)
        setEmptyView(title: viewModel.title, message: viewModel.message, isLoading: false, image: viewModel.image)
    }
    
    fileprivate func isActiveElement(isActive: Bool) {
        viewTo.isHidden = isActive
        viewFrom.isHidden = isActive
        titleDescription.isHidden = isActive
        amountTextField.isHidden = isActive
        resultLabel.isHidden = isActive
        buttonConvert.isHidden = isActive
    }
    
    func converted(sum: String) {
        resultLabel.text = sum
    }
    
    func load(toViewModel: HomeViewModel, fromViewModel: HomeViewModel) {
        viewTo.configure(viewModel: toViewModel)
        viewFrom.configure(viewModel: fromViewModel)
        removeEmptyView()
        isActiveElement(isActive: false)

    }
}

