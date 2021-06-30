//
//  CurrencyConverterViewController.swift
//  mobile-challenge
//
//  Created by gabriel on 29/11/20.
//

import UIKit

class CurrencyConverterViewController: UIViewController {
    
    // MARK: View Model
    private let viewModel: CurrencyConverterViewModel
        
    // MARK: UI Elements
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.refreshControl = UIRefreshControl()
        scrollView.refreshControl?.tintColor = .systemGray6
        scrollView.refreshControl?.addTarget(self, action: #selector(scrollViewRefresh(_:)), for: .valueChanged)
        return scrollView
    }()
    private let contentView: UIView = {
        let contentView = UIView(frame: .zero)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private let buttonsStack: UIStackView = {
        let buttonsStack = UIStackView(frame: .zero)
        buttonsStack.translatesAutoresizingMaskIntoConstraints = false
        buttonsStack.backgroundColor = .clear
        buttonsStack.axis = .horizontal
        buttonsStack.alignment = .center
        buttonsStack.distribution = .fill
        return buttonsStack
    }()
    
    private let originButtonStack: UIStackView = UIStackView(frame: .zero)
    private let originCurrencyButton: SelectCurrencyButton = SelectCurrencyButton(ofType: .origin)
    
    private let destinyButtonStack: UIStackView = UIStackView(frame: .zero)
    private let destinyCurrencyButton: SelectCurrencyButton = SelectCurrencyButton(ofType: .destiny)
    
    private let arrowRight: UILabel = {
        let arrow = UILabel()
        arrow.text = "➜"
        arrow.font = .boldSystemFont(ofSize: 60)
        arrow.adjustsFontSizeToFitWidth = true
        arrow.textAlignment = .center
        arrow.textColor = .white
        return arrow
    }()
    
    private let textField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .systemGray6
        textField.layer.cornerRadius = 10
        textField.textAlignment = .center
        textField.adjustsFontSizeToFitWidth = true
        textField.font = .systemFont(ofSize: 32, weight: .heavy)
        textField.textColor = .systemGray
        textField.keyboardType = .decimalPad
        textField.placeholder = "Entre com o valor"
        return textField
    }()
    
    private let convertedCurrencyLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 32, weight: .heavy)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 10
        label.backgroundColor = .systemGray6
        label.textColor = .systemGray
        return label
    }()
    
    private let lastUpdateLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.textAlignment = .center
        label.textColor = .systemGray6
        label.text = "Última atualização em: --"
        return label
    }()
    
    // MARK: Delegates
    private let textFieldDelegate: InputCurrencyTextFieldDelegate = InputCurrencyTextFieldDelegate()
    
    // MARK: Init
    init(viewModel: CurrencyConverterViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        removeObservers()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.start()
        
        setupAutoScrollWhenKeyboardShowsUp()
        setupViewModel()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    // MARK: Setup methods
    private func setupViewModel() {
        viewModel.delegate = self
    }
    
    private func setupUI() {
        view.backgroundColor = .black
        
        setupScrollView()
        setupButtons()
        setupTextField()
        setupConvertedCurrencyLabel()
        setupLastUpdateLabel()
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        setupScrollViewConstraints()
        setupContentViewConstraints()
        setupButtonsStackConstraints()
        setupTextFieldConstraints()
        setupConvertedCurrencyLabelConstraints()
        setupLastUpdateLabelConstraints()
    }
    
    private func setupScrollView() {
        // Add scrollView as subview of view
        view.addSubview(scrollView)

        // Add contentView as subview of scrollView
        scrollView.addSubview(contentView)
    }
    
    func setupScrollViewConstraints() {
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    func setupContentViewConstraints() {
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
    }
    
    private func setupButtons() {
        // Add ButtonsStack as subview of scrollView
        contentView.addSubview(buttonsStack)
        
        // Setup origin button
        setupSingleButton(label: "Origem:", stack: originButtonStack, button: originCurrencyButton)
        
        // Add arrow as subview of buttonsStack
        buttonsStack.addArrangedSubview(arrowRight)
        
        // Setup destiny button
        setupSingleButton(label: "Destino:", stack: destinyButtonStack, button: destinyCurrencyButton)
    }
    
    private func setupButtonsStackConstraints() {
        buttonsStack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -100).isActive = true
        buttonsStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30).isActive = true
        buttonsStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30).isActive = true
    }
    
    private func setupSingleButton(label: String, stack: UIStackView, button: SelectCurrencyButton) {
        // Setup stack attributes
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.backgroundColor = .clear
        stack.axis = .vertical
        stack.spacing = 5
        
        // Add stack as subview of buttonsStack
        buttonsStack.addArrangedSubview(stack)
        
        // Setup button upperLabel
        let upperLabel = UILabel()
        upperLabel.text = label
        upperLabel.textColor = .systemGray6
        
        // Add upperLabel as subview of stack
        stack.addArrangedSubview(upperLabel)
        
        // Setup button
        button.setTitle("-", for: .normal)
        button.addTarget(self, action: #selector(currencyButtonDidTap(_:)), for: .touchUpInside)
        
        // Add button as subview of stack
        stack.addArrangedSubview(button)
    }
    
    private func setupTextField() {
        // Setup textField delegate
        textField.delegate = textFieldDelegate
        textFieldDelegate.textChanged = self.inputTextChanged
        textFieldDelegate.shouldBeginEdit = self.isTextFieldEnabled
        
        contentView.addSubview(textField)
    }
    
    private func setupTextFieldConstraints() {
        textField.topAnchor.constraint(equalTo: buttonsStack.bottomAnchor, constant: 30).isActive = true
        textField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30).isActive = true
        textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 45).isActive = true
    }
    
    private func setupConvertedCurrencyLabel() {
        contentView.addSubview(convertedCurrencyLabel)
    }
    
    private func setupConvertedCurrencyLabelConstraints() {
        convertedCurrencyLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 30).isActive = true
        convertedCurrencyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30).isActive = true
        convertedCurrencyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30).isActive = true
        convertedCurrencyLabel.heightAnchor.constraint(equalToConstant: 45).isActive = true
    }
    
    private func setupLastUpdateLabel() {
        contentView.addSubview(lastUpdateLabel)
    }
    
    private func setupLastUpdateLabelConstraints() {
        lastUpdateLabel.topAnchor.constraint(equalTo: convertedCurrencyLabel.bottomAnchor, constant: 30).isActive = true
        lastUpdateLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
        lastUpdateLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
    }
    
    // MARK: Bind methods
    private func inputTextChanged() {
        let response = viewModel.convert(textField.text)
        
        self.textField.text = response.input
        self.convertedCurrencyLabel.text = response.output
    }
    
    private func isTextFieldEnabled() -> Bool {
        return viewModel.isConvertEnabled()
    }
    
    // MARK: Button target method
    @objc private func currencyButtonDidTap(_ sender: SelectCurrencyButton) {
        // Remove keyboard focus
        view.endEditing(true)
        
        // Reset scroll view
        scrollView.contentOffset = .zero
        scrollView.refreshControl?.endRefreshing()
        
        // Call viewModel to handle button interaction
        viewModel.buttonDidTap(sender.type)
    }
    
    // MARK: Observers handlers
    override func setScrollViewContentInset(_ inset: UIEdgeInsets) {
        // Adjust the scrollView so the textField and the label doesn't hide when keyboard appears
        scrollView.contentInset = inset
        scrollView.contentSize = contentView.bounds.size
        
        let distanceLabelBottom = scrollView.contentSize.height - convertedCurrencyLabel.frame.origin.y
        let offsetY = inset.bottom == 0 ? 0 : scrollView.contentSize.height - scrollView.bounds.height + scrollView.contentInset.bottom - distanceLabelBottom + convertedCurrencyLabel.bounds.height + 30
        scrollView.setContentOffset(CGPoint(x: 0, y: offsetY), animated: true)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        // Reset scroll view when device orientation changes
        view.endEditing(true)
        resetScrollView()
    }
    
    private func resetScrollView() {
        scrollView.contentSize = .zero
        scrollView.contentInset = .zero
        scrollView.contentOffset = .zero
    }
    
    // MARK: Refresh control handler
    @objc private func scrollViewRefresh(_ sender: UIRefreshControl) {
        viewModel.start()
    }
}

// MARK: CurrencyConverterViewModelDelegate
extension CurrencyConverterViewController: CurrencyConverterViewModelDelegate {
    
    func originChanged() {
        let newTitle = viewModel.originCurrency.isEmpty ? "-" : viewModel.originCurrency
        originCurrencyButton.setTitle(newTitle, for: .normal)
        textField.text = ""
        convertedCurrencyLabel.text = ""
    }
    
    func destinyChanged() {
        let newTitle = viewModel.destinyCurrency.isEmpty ? "-" : viewModel.destinyCurrency
        destinyCurrencyButton.setTitle(newTitle, for: .normal)
        textField.text = ""
        convertedCurrencyLabel.text = ""
    }
    
    func dataFetched() {

        DispatchQueue.main.async {
            self.scrollView.refreshControl?.endRefreshing()
            // Bug on refresh control when end with alert, must set offset back to stop the refresh
            self.scrollView.setContentOffset(.zero, animated: true)
        }
        
        guard let lastUpdate = viewModel.getLastUpdate() else {
            DispatchQueue.main.async {
                self.lastUpdateLabel.text = "Ocorreu um erro no carregamento. Deslize para cima para tentar novamente."
                self.originCurrencyButton.setTitle("-", for: .normal)
                self.destinyCurrencyButton.setTitle("-", for: .normal)
                self.textField.text = ""
                self.convertedCurrencyLabel.text = ""
            }
            return
        }
        
        DispatchQueue.main.async {
            self.lastUpdateLabel.text = "Última atualização em: \(String(describing: lastUpdate))"
        }
    }
    
    func createAlert(title: String, message: String, handler: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(.init(title: "OK", style: .cancel, handler: {_ in handler?()}))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}
