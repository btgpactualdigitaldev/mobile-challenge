import UIKit

final class MainScreenViewController: UIViewController {
    
    @IBOutlet var currencyButton1: UIButton!
    @IBOutlet var currencyButton2: UIButton!
    @IBOutlet var valueTextField: UITextField!
    @IBOutlet var finalValueLabel: UILabel!
    @IBOutlet var finalValueView: UIView!
    @IBOutlet var makeAConversionButton: UIButton!
    
    
    private let conversionManager = ConversionManager()
    private let currencyScreenViewController = CurrencyScreenViewController()
    private var initialCurrency = ""
    private var finalCurrency = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        conversionManager.getQuotes()
        setupFinalValueLabel()
        setupMakeAConversionButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        valueTextField.resignFirstResponder()
    }
    
    @IBAction func chooseCurrency1(_ sender: UIButton) {
        currencyScreenViewController.selectedCurrency = { [weak self] name in
            self?.currencyButton1.setTitle(name, for: .normal)
            self?.initialCurrency = name
        }
        navigationController?.pushViewController(currencyScreenViewController, animated: true)
    }
    
    @IBAction func chooseCurrency2(_ sender: UIButton) {
        currencyScreenViewController.selectedCurrency = { [weak self] name in
            self?.currencyButton2.setTitle(name, for: .normal)
            self?.finalCurrency = name
        }
        navigationController?.pushViewController(currencyScreenViewController, animated: true)
    }
    
    @IBAction func convert(_ sender: Any) {
        makeAConvertion()
    }
    
    
    private func makeAConvertion() {
        let formatter = configNumberFormatter()
        let value = Double(valueTextField.text ?? "") ?? 0.0
        finalValueLabel.text = formatter.string(for: conversionManager.makeAConversion(initialCurrency: initialCurrency, finalCurrency: finalCurrency, value: value))
    }
    
    private func configNumberFormatter() -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.alwaysShowsDecimalSeparator = true
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    private func setupFinalValueLabel() {
        finalValueLabel.layer.cornerRadius = 3.0
        finalValueLabel.layer.masksToBounds = true
        finalValueLabel.layer.borderWidth = 0.5
        finalValueLabel.layer.borderColor = UIColor.systemGray4.cgColor
        
        finalValueView.layer.shadowColor = UIColor.black.cgColor
        finalValueView.layer.shadowOpacity = 0.4
        finalValueView.layer.shadowOffset = .zero
        finalValueView.layer.shadowRadius = 4.0
        finalValueView.layer.shouldRasterize = true
    }
    
    private func setupMakeAConversionButton() {
        makeAConversionButton.layer.cornerRadius = 5.0
        makeAConversionButton.layer.masksToBounds = true
    }
}
