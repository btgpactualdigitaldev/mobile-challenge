//
//  ViewController.swift
//  EasyMoneyExchanger
//
//  Created by Leon on 07/12/20.
//

import Lottie
import UIKit
import Network

class ExchangeViewController: UITableViewController, UpdateLabels, Storyboarded {

    var  isConnected = true
    var  canAccessLists = true
    var  exchangeModalViewController = ExchangeModalViewController()
    var  viewModel: ExchangeViewModel?
    var  currencyViewModel: SupportedCurrenciesViewModel?
    var  animationView: AnimationView?
    weak var coordinator: MainCoordinator?

    // MARK: - Override Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        monitorNetwork(monitor: NWPathMonitor(), queue: DispatchQueue(label: "Network"))
        if isConnected {
            setupAnimationView()
            self.viewModel?.initApplication(tableView: self.tableView, viewController: self)
            self.loadLabels()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        playHomeAnimation()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        playHomeAnimation()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if self.traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
           traitCollection.userInterfaceStyle == .dark ? setupAnimationView() : setupAnimationView()
        }
    }

    // MARK: - Outlets UI Labels

    @IBOutlet weak var currencyConvertedLabel: UILabel!
    @IBOutlet weak var currencyNameLabel: UILabel!
    @IBOutlet weak var currencyTimestampLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel! {
        didSet {
            amountLabel.text = Strings.ExchangeScreen.amountLabel
        }
    }

    @IBOutlet weak var fromLabel: UILabel! {
        didSet {
            fromLabel.text = Strings.ExchangeScreen.fromLabel
        }
    }

    @IBOutlet weak var toLabel: UILabel! {
        didSet {
            toLabel.text = Strings.ExchangeScreen.toLabel
        }
    }

    // MARK: - Outlets UI TextField

    @IBOutlet weak var amountTextInput: UITextField! {
        didSet {
            //Adding a Done Button above the keyboard
            let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 35))
            let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
            let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(onPressDone))

            doneButton.tintColor = Colors.labelColor
            toolbar.sizeToFit()
            toolbar.setItems([flexibleSpace, doneButton], animated: true)

            amountTextInput.keyboardType = UIKeyboardType.decimalPad
            amountTextInput.inputAccessoryView = toolbar
        }
    }

    // MARK: - Outlets AnimationView
    @IBOutlet weak var homeAnimationView: AnimationView! {
        didSet {
            animationView = .init(name: "homeAnimation")
            animationView?.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
            animationView?.contentMode = .scaleAspectFit
            homeAnimationView.addSubview(animationView!)
        }
    }

    // MARK: - Outlets UI Button

    @IBOutlet weak var currenciesListButton: UIButton! {
        didSet {
            // Override Button Icon
            let buttonIcon = UIImage(
                systemName: "list.bullet",
                withConfiguration: UIImage.SymbolConfiguration(weight: .black)
            )?.withTintColor(Colors.primaryColor!, renderingMode: .alwaysOriginal)
            currenciesListButton.setTitle("", for: .normal)
            currenciesListButton.setImage(buttonIcon, for: .normal)
        }
    }

    @IBOutlet weak var updateCurrencyButton: UIButton! {
        didSet {
            // Override Button Icon
            let buttonIcon = UIImage(
                systemName: "goforward", withConfiguration: UIImage.SymbolConfiguration(weight: .black)
            )?.withTintColor(Colors.primaryColor!, renderingMode: .alwaysOriginal)
            updateCurrencyButton.setTitle("", for: .normal)
            updateCurrencyButton.setImage(buttonIcon, for: .normal)
        }
    }

    @IBOutlet weak var switchCurrencyButton: UIButton! {
        didSet {
            // Override Button Icon
            let buttonIcon = UIImage(
                systemName: "repeat", withConfiguration: UIImage.SymbolConfiguration(weight: .light)
            )?.withTintColor(Colors.whiteLabelColor, renderingMode: .alwaysOriginal)
            switchCurrencyButton.setImage(buttonIcon, for: .normal)
            switchCurrencyButton.setTitle("", for: .normal)
            switchCurrencyButton.layer.cornerRadius = 10
            switchCurrencyButton.backgroundColor = Colors.primaryColor
        }
    }

    @IBOutlet weak var fromButton: UIButton! {
        didSet {
            // Override Button Icon
            let buttonIcon = UIImage(
                systemName: "chevron.down", withConfiguration: UIImage.SymbolConfiguration(weight: .light)
            )?.withTintColor(Colors.labelColor, renderingMode: .alwaysOriginal)
            fromButton.contentHorizontalAlignment = .left
            fromButton.setTitleColor(Colors.labelColor, for: .normal)
            fromButton.setImage(buttonIcon, for: .normal)
            fromButton.layer.cornerRadius = 5
        }
    }

    @IBOutlet weak var toButton: UIButton! {
        didSet {
            // Override Button Icon
            let buttonIcon = UIImage(
                systemName: "chevron.down", withConfiguration: UIImage.SymbolConfiguration(weight: .light)
            )?.withTintColor(Colors.labelColor, renderingMode: .alwaysOriginal)
            toButton.contentHorizontalAlignment = .left
            toButton.setTitleColor(Colors.labelColor, for: .normal)
            toButton.setImage(buttonIcon, for: .normal)
            toButton.layer.cornerRadius = 5
        }
    }

    @IBOutlet weak var errorMessage: UILabel!

    @IBOutlet weak var convertButton: UIButton! {
        didSet {
            convertButton.setTitle(Strings.ExchangeScreen.convertButton, for: .normal)
            convertButton.setTitleColor(Colors.whiteLabelColor, for: .normal)
            convertButton.backgroundColor = Colors.primaryColor
            convertButton.layer.cornerRadius = 5
        }
    }

    // MARK: - UI Actions

    @objc func onPressDone() {
        view.endEditing(true)
    }

    @IBAction func onPressSwitchCurrencies(_ sender: Any) {
        let from = viewModel?.coreData.exchangeItems![0].from
        let to = viewModel?.coreData.exchangeItems![0].to
        viewModel?.invetCurrencies(tableView: tableView, fromCurrency: from!, toCurrency: to!)
        updateFrom(from: (viewModel?.coreData.exchangeItems![0].from)!)
        updateTo(to: (viewModel?.coreData.exchangeItems![0].to)!)
    }
    @IBAction func goToCurrenciesScreen(_ sender: Any) {
        coordinator?.goToCurrenciesScreen(with: currencyViewModel!)
    }
    @IBAction func updateCurrencyValues(_ sender: Any) {
        if isConnected {
            viewModel?.updateLocalData(uiTableView: tableView, viewController: self)
            viewModel?.rotateButton(updateCurrencyButton: updateCurrencyButton)
            tableView.reloadData()
            loadLabels()
        } else {
            let errorAlert = UIAlertController(title: "Error", message: Strings.ExchangeScreen.internetError, preferredStyle: .alert)
            errorAlert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            present(errorAlert, animated: true)
        }
    }
    @IBAction func onPressFrom(_ sender: Any) {
        viewModel?.showCurrencieModal(currenciesView: self, viewModel: viewModel!, selectedButton: ButtonType.from)
    }
    @IBAction func onPressTo(_ sender: Any) {
        viewModel?.showCurrencieModal(currenciesView: self, viewModel: viewModel!, selectedButton: ButtonType.to)
    }
    @IBAction func onPressConvert(_ sender: Any) {

        if !amountTextInput.text!.isEmpty {
            let amount = Float(amountTextInput.text!)
            let from = viewModel?.coreData.exchangeItems![0].from
            let to = viewModel?.coreData.exchangeItems![0].to
            let currencyName = Flags.codeToFlag[(viewModel?.coreData.exchangeItems![0].to)!]
            currencyConvertedLabel.text = String(format: "%.3f", ((viewModel?.getCurrencyConverted( fromCurrency: from!, toCurrency: to!, amount: amount!))!))
            currencyNameLabel.text = String((currencyName?.dropFirst())!)
            errorMessage.text = ""
        } else {
            errorMessage.text = Strings.ExchangeScreen.errorMessage
        }
    }

    // MARK: - Delegate Methods
    func updateFrom(from: String) {
        fromButton.setTitle(Flags.codeToFlag[from], for: .normal)
    }

    func updateTo(to: String) {
        toButton.setTitle(Flags.codeToFlag[to], for: .normal)
    }

    // MARK: - Other Actions

    func monitorNetwork(monitor: NWPathMonitor, queue: DispatchQueue) {
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                DispatchQueue.main.async {
                    self.isConnected = true
                }
            } else {
                DispatchQueue.main.async {
                    self.isConnected = false
                }
            }
        }

        monitor.start(queue: queue)
    }

    func showError(error: String) {
        let errorAlert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        errorAlert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(errorAlert, animated: true)
    }

    func setButtonsActivation(state: Bool) {
        toButton.isEnabled = state
        fromButton.isEnabled = state
        switchCurrencyButton.isEnabled = state
        convertButton.isEnabled = state
        currenciesListButton.isEnabled = state
    }

    func loadLabels() {
        if (viewModel?.coreData.rateItems!.count)! > 0 {
            let exchangeItems = viewModel?.coreData.exchangeItems![0]
            let timestamp = viewModel?.coreData.rateItems![0].timeStamp
            currencyTimestampLabel.text = viewModel?.getDateString(timestamp: timestamp!)
            updateTo(to: (exchangeItems?.to)!)
            updateFrom(from: (exchangeItems?.from)!)
        }
    }

    func playHomeAnimation() {
        animationView?.play()
        animationView?.loopMode = .loop
    }

    func setupAnimationView() {
        let strokeKeyPath = AnimationKeypath(keypath: "**.Group 1.Stroke 1.Color")
        let fillKeyPath = AnimationKeypath(keypath: "**.Group 1.Fill 1.Color")
        let colorProvider = ColorValueProvider(Colors.primaryColor!.lottieColorValue)
        animationView?.animationSpeed = 0.1
        animationView?.setValueProvider(colorProvider, keypath: strokeKeyPath)
        animationView?.setValueProvider(colorProvider, keypath: fillKeyPath)
    }
}
