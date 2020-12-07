//
//  ConverterViewController.swift
//  mobileChallenge
//
//  Created by Renato Carvalhan on 03/12/20.
//  Copyright © 2020 Renato Carvalhan. All rights reserved.
//

import UIKit

class ConverterViewController: UIViewController {
    
    private var viewModel: ConverterViewModel
    private var value: Double = 1.0
    
    private lazy var containerHerderView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 20.0
        
        return stackView
    }()
    
    private lazy var stackViewToTextField: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 0
        
        return stackView
    }()
    
    lazy var currencyButton: UIButton = {
        let button: UIButton = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30.0)
        button.layer.cornerRadius = 10.0
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.black.cgColor
        button.addTarget(
             self, action: #selector(changeBaseCurrency),
             for: .touchUpInside)
        
       return button
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.text = "1.00"
        textField.font = UIFont.systemFont(ofSize: 25.0, weight: .medium)
        textField.textAlignment = .right
        textField.keyboardType = .decimalPad
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        return textField
    }()
    
    private lazy var textFieldSeparatorView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.keyboardDismissMode = .onDrag
        tableView.rowHeight = 70
        
        tableView.registerReusableCell(ConverterCurrencyCell.self)

        return tableView
    }()
    
    init(viewModel: ConverterViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewModel.title
        navigationItem.rightBarButtonItem = UIBarButtonItem(
        barButtonSystemItem: .add,
        target: self, action: #selector(addCurrency))
        setupView()
    }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateView()
    }
    
    private func updateView() {
        currencyButton.setTitle(viewModel.titleCurrencyButton, for: .normal)
        tableView.reloadData()
    }
    
    private func setupView() {
        self.view.addSubview(containerHerderView)
        self.containerHerderView.addSubview(stackView)
        self.stackView.addArrangedSubview(currencyButton)
        self.stackView.addArrangedSubview(stackViewToTextField)
        self.stackViewToTextField.addArrangedSubview(textField)
        self.stackViewToTextField.addArrangedSubview(textFieldSeparatorView)
        self.view.addSubview(tableView)
        
        buildConstraints()
    }
    
    private func buildConstraints() {
        
        NSLayoutConstraint.activate([
            containerHerderView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            containerHerderView.leftAnchor.constraint(equalTo: view.leftAnchor),
            containerHerderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerHerderView.heightAnchor.constraint(equalToConstant: 90.0),
            
            textField.heightAnchor.constraint(equalToConstant: 40.0),
            textFieldSeparatorView.heightAnchor.constraint(equalToConstant: 5.0),
            
            stackView.topAnchor.constraint(equalTo: containerHerderView.topAnchor, constant: 10),
            stackView.leftAnchor.constraint(equalTo: containerHerderView.leftAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: containerHerderView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: containerHerderView.bottomAnchor, constant: -20),
            
            tableView.topAnchor.constraint(equalTo: containerHerderView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension ConverterViewController {
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        self.value = Double(text) ?? 0.0
        tableView.reloadData()
    }
    
    @objc func addCurrency() {
        self.viewModel.showCurrencies(type: .addNewCurrency)
    }
    
    @objc func changeBaseCurrency() {
        self.viewModel.showCurrencies(type: .changeBaseCurrency)
    }
    
}

//MARK: - UITableViewDelegate and UITableViewDataSource
extension ConverterViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(indexPath: indexPath) as ConverterCurrencyCell
        let from = viewModel.baseCurrency()
        let currency = viewModel.favoritedCurrencies[indexPath.row]
        cell.setupCell(from: from!, to: currency, value: value)
        return cell
    }
}
