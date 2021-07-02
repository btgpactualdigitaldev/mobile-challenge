//
//  CurrencyConverterViewController.swift
//  mobile-challenge-UIKit
//
//  Created by Lucas Fernandez Nicolau on 14/12/20.
//

import UIKit

class CurrencyConverterViewController: UIViewController, ViewCodable, AlertError {

    private weak var coordinator: CurrencyChoosing?
    private var viewModel: CurrencyConverterViewModel

    @DetailsButton(.origin) var originCurrencyButton
    @DetailsButton(.target) var targetCurrencyButton

    @CurrencyTextField(.origin) var originCurrencyTextField
    @CurrencyTextField(.target) var targetCurrencyTextField

    @FloatingActionButton var fab

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        scrollView.addSubview(stackView)
        scrollView.addSubview(lastUpdateLabel)

        return scrollView
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            originCurrencyButton,
            originCurrencyTextField,
            targetCurrencyButton,
            targetCurrencyTextField
        ])

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = DesignSystem.Spacing.min
        stackView.alignment = .fill

        return stackView
    }()

    private lazy var lastUpdateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: DesignSystem.FontSize.labelDetails)
        label.textColor = DesignSystem.Color.gray
        label.textAlignment = .center
        label.numberOfLines = 2

        return label
    }()

    init(coordinator: CurrencyChoosing, viewModel: CurrencyConverterViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.coordinator = coordinator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        setConstraints()
    }

    func setUp() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: LiteralText.updateRates,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(updateRates))
        view.backgroundColor = DesignSystem.Color.background
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = LiteralText.currencyConverterViewControllerTitle

        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))

        originCurrencyTextField.delegate = self

        _originCurrencyButton.onTouch = { [weak self] in
            self?.coordinator?.chooseCurrency(type: .origin) { [weak self] currency in
                self?.viewModel.setSelectedCurrency(currency, for: .origin)
            }
        }
        _originCurrencyTextField.onTextChanged = { [weak self] text in
            self?.convert(text)
        }

        _targetCurrencyButton.onTouch = { [weak self] in
            self?.coordinator?.chooseCurrency(type: .target) { [weak self] currency in
                self?.viewModel.setSelectedCurrency(currency, for: .target)
            }
        }

        _fab.onTouch = { [weak self] in
            guard let self = self else { return }
            self.viewModel.invertCurrencies()
            self.convert(self.originCurrencyTextField.text)
        }

        viewModel.onUpdate = { [weak self] in
            guard let self = self else { return }
            self.updateUI()
            self.convert(self.originCurrencyTextField.text)
        }
        updateUI()
    }

    private func convert(_ text: String?) {
        guard let text = text else { return }
        viewModel.convert(text: text) { [weak self] convertedText in
            self?._targetCurrencyTextField.setText(convertedText)
        }
    }

    @objc func updateRates() {
        viewModel.getLiveRate()
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    func setConstraints() {
        view.addSubview(scrollView)
        view.addSubview(fab)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            originCurrencyButton.heightAnchor.constraint(equalToConstant: DesignSystem.TextField.height),
            targetCurrencyButton.heightAnchor.constraint(equalToConstant: DesignSystem.TextField.height),
            originCurrencyTextField.heightAnchor.constraint(equalToConstant: DesignSystem.TextField.height),
            targetCurrencyTextField.heightAnchor.constraint(equalToConstant: DesignSystem.TextField.height),

            stackView.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: DesignSystem.Spacing.leadingTopSafeArea),
            stackView.topAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.topAnchor, constant: DesignSystem.Spacing.leadingTopSafeArea),
            stackView.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor, constant: DesignSystem.Spacing.trailingBottomSafeArea),

            lastUpdateLabel.topAnchor.constraint(
                equalTo: stackView.bottomAnchor,
                constant: DesignSystem.Spacing.leadingTopSafeArea
            ),
            lastUpdateLabel.leadingAnchor.constraint(
                equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor,
                constant: DesignSystem.Spacing.leadingTopSafeArea
            ),
            lastUpdateLabel.trailingAnchor.constraint(
                equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor,
                constant: DesignSystem.Spacing.trailingBottomSafeArea
            ),

            fab.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: DesignSystem.Spacing.trailingBottomSafeArea),
            fab.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: DesignSystem.Spacing.trailingBottomSafeArea)
        ])
    }

    func updateUI() {
        _originCurrencyTextField.setCurrencyCode(viewModel.originCurrency.code)
        _targetCurrencyTextField.setCurrencyCode(viewModel.targetCurrency.code)

        _originCurrencyButton.setDetailsLabel(text: viewModel.originCurrency.name)
        _targetCurrencyButton.setDetailsLabel(text: viewModel.targetCurrency.name)

        lastUpdateLabel.text = viewModel.getLastUpdateDate()
    }
}

extension CurrencyConverterViewController: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        guard let text = textField.text else {
            return false
        }

        if text.isEmpty && string.isDecimalSeparator() {
            textField.text?.append("0\(String.decimalSeparator)")
        }

        return canAddCharacter(text: text, range: range, newText: string)
    }

    /// Verify if a character should be added into the text field
    /// - Parameters:
    ///   - text: current text field text
    ///   - range: text to be placed into text field range
    ///   - newText: text to be placed into text field
    /// - Returns: true or false
    private func canAddCharacter(text: String, range: NSRange, newText: String) -> Bool {

        let completeText = "\(text)\(newText)"

        if completeText.numberOfDecimalSeparators() > 1 {
            return false
        }

        let range = NSRange(location: .zero, length: completeText.utf16.count)
        guard let regex = try? NSRegularExpression(pattern: #"\b([0-9]+)(\,{0,1}|\.{0,1})([0-9]*)\b"#) else {
            return false
        }

        return regex.firstMatch(in: completeText, options: [], range: range) != nil
            || newText.isEmpty
    }
}
