import UIKit

final class CurrencyScreenViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var currencies: [Currency] = []
    private let currencyRequest = CurrencyRequest()
    var selectedCurrency: ((String) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCurrencies()
        setupTableView()
        title = "Currencies"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.setContentOffset(.zero, animated: true)
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.tintColor = UIColor(named: "main")
    }
    
    private func setupTableView() {
        let nib = UINib(nibName: "CurrencyTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func loadCurrencies() {
        currencyRequest.getCurrency { (currencies) in
            DispatchQueue.main.async { [weak self] in
                self?.currencies = (currencies.convertCurrencies()).sorted { (currency1, currency2) -> Bool in
                    currency1.name < currency2.name
                }
                self?.tableView.reloadData()
            }
        } onError: { (error) in
            switch error {
            case .invalidJSON:
                print("Invalid JSON")
            case .noData:
                print("no Data")
            case .noResponse:
                print("No Response")
            case .responseStatusCode(cod: 404):
                print("Not Found")
            case .taskError(let error):
                print(error)
            case .url:
                print("Problem with url")
            default:
                print("Another type of error")
            }
        }
    }
}

//MARK: - UITableViewDataSource
extension CurrencyScreenViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CurrencyTableViewCell else {
           fatalError("Cell not found")
        }
        let currency = currencies[indexPath.row]
        cell.fillCell(currency: currency)
        cell.selectionStyle = .none
        let view = UIView()
        view.backgroundColor = .clear
        cell.backgroundColor = .clear
        cell.backgroundView = view
        return cell
    }
}
//MARK: - UITableViewDelegate
extension CurrencyScreenViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedCurrency?(currencies[indexPath.row].name)
        navigationController?.popViewController(animated: true)
    }
}
