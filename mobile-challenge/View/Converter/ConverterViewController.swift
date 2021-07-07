//
//  ViewController.swift
//  mobile-challenge
//
//  Created by Murilo Teixeira on 25/09/20.
//

import UIKit

protocol ConverterViewControllerCoordinator: AnyObject {
    func currencyListView(buttonTapped: ButtonTapped)
}

class ConverterViewController: UIViewController {
    
    let sourceButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGray
        button.setTitle("Escolher Origem", for: .normal)
        button.addTarget(self, action: #selector(goToCurrrencyListButton(_:)), for: .touchUpInside)
        return button
    }()
    
    let destinyButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGray
        button.setTitle("Escolher Destino", for: .normal)
        button.addTarget(self, action: #selector(goToCurrrencyListButton(_:)), for: .touchUpInside)
        return button
    }()
    
    let inputValueTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.textAlignment = .right
        textField.keyboardType = .decimalPad
        textField.placeholder = "0"
        return textField
    }()
    
    lazy var converterResultLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.layer.borderWidth = 0.2
        label.layer.borderColor = UIColor.lightGray.cgColor
        label.layer.cornerRadius = 5
        return label
    }()
    
    let errorLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        let font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.font = font
        return label
    }()
    
    let converterButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemIndigo
        button.setTitle("Converter", for: .normal)
        button.addTarget(self, action: #selector(converterButtonAction(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var sourceStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [sourceButton, inputValueTextField])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    lazy var destinyStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [destinyButton, converterResultLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [sourceStackView, destinyStackView, errorLabel, converterButton])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    weak var coordinator: ConverterViewControllerCoordinator?
    let viewModel: ConverterViewModel
    
    //MARK:- init
    init(viewModel: ConverterViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        view.backgroundColor = .systemBackground
        errorLabel.text = ""
        title = "Conversor de moedas"
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupButtons()
    }

    @objc func goToCurrrencyListButton(_ sender: UIButton) {
        if sender == sourceButton {
            coordinator?.currencyListView(buttonTapped: .source)
        }
        else if sender == destinyButton {
            coordinator?.currencyListView(buttonTapped: .destiny)
        }
    }
    
    @objc func converterButtonAction(_ sender: Any) {
        do {
            try viewModel.currenciesValidation()
            let inputValue = try viewModel.inputValidator(inputValueTextField.text)
            let valueDouble = viewModel.performConversion(inputValue)
            converterResultLabel.text = String(format: "%.2f", valueDouble)
            
            errorLabel.text = "\(viewModel.source?.code ?? "") -> \(viewModel.destiny?.code ?? "")"
            errorLabel.textColor = .label
        } catch {
            errorLabel.text = error.localizedDescription
            errorLabel.textColor = .systemRed
        }
        
    }
    
    func setupButtons() {
        if let source = viewModel.source {
            sourceButton.setTitle(source.code, for: .normal)
        }
        
        if let destiny = viewModel.destiny {
            destinyButton.setTitle(destiny.code, for: .normal)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

//MARK:- ViewCodable
extension ConverterViewController: ViewCodable {
    var horizontalPadding: CGFloat { 20 }

    func setupHierarchyViews() {
        view.addSubview(mainStackView)
    }

    func setupConstraints() {
        setupSourceStackViewConstraints()
    }
    
    func setupSourceStackViewConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mainStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -horizontalPadding),
            mainStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: horizontalPadding),
            mainStackView.heightAnchor.constraint(equalToConstant: 200),
        ])
    }
    
    func setupAdditionalConfiguration() {
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
    }
}
