//
//  TableCurrencyViewController.swift
//  mobileChallenge
//
//  Created by Mateus Augusto M Ferreira on 25/11/20.
//

//Valor que quer converter (Real) / (Dolar) * Valor Destino

//1 dolar = R$ 5.00
//1 dolar = EU 2.00
//
//R$10.00 = EU?



import Foundation
import UIKit


//MARK: -Protocol
protocol PassDataDelegate: class {
    func passCurrencyAndNameData(name:String, quote:Double, to:CurrencyViewModelReceiver)
}

//MARK: -Class
class TableCurrencyViewController: UIViewController {
    
    
    //MARK: -Variables
    //Variables
    weak var coordinator: CoordinatorManager?
    var baseView = TableCurrencyView()
    var currencyViewModel = TableCurrencyVM()
    var filteredCurrencies = [String]()
    weak var dataDelegate: PassDataDelegate?

    //MARK: -Load View
    override func loadView() {
        self.view = baseView
    }
    
    //MARK: -view Will Appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        currencyViewModel.delegateData = self
        currencyViewModel.delegate = self
    }
    
    //MARK: -viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
      
        baseView.tableCurrencyView.delegate = self
        baseView.tableCurrencyView.dataSource = self
    }
}

//MARK: -Extensions
extension TableCurrencyViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! TableCurrencyCell
        currencyViewModel.delegateData?.didReceiveData(cell.nameCurrency, cell.quote, .currencyDestiny)
    }
}

extension TableCurrencyViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.currencyViewModel.quotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         
        guard let cell = baseView.tableCurrencyView.dequeueReusableCell(withIdentifier: Identifier.Cell.tableCurrencyCell, for: indexPath) as? TableCurrencyCell else {
            fatalError("Could not create new cell.")
        }
        
        let quoteKey = currencyViewModel.quotesArray[indexPath.row]
        let quotesValue = currencyViewModel.quotes[quoteKey] ?? 0.0
        
        cell.textLabel?.text = "\(quoteKey.components(separatedBy: "USD")[1])"
        cell.detailTextLabel?.text = "\(quotesValue.roundToDecimal(2))"
        
        return cell
    }
}

extension TableCurrencyViewController: CurrencyDataVMDelegate{
    func didReceiveCurrencies() {
        DispatchQueue.main.async {
            self.baseView.tableCurrencyView.reloadData()
        }
    }
}

extension TableCurrencyViewController: ReceiverDataDelegate{
    func didReceiveData(_ nameCurrency: String, _ value: Double, _ to: CurrencyViewModelReceiver) {
        dataDelegate?.passCurrencyAndNameData(name: nameCurrency, quote: value, to: to)
        self.dismiss(animated: true, completion: nil)
    }
}
