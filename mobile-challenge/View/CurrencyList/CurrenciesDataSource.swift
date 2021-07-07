//
//  CurreenciesDataSource.swift
//  mobile-challenge
//
//  Created by Murilo Teixeira on 26/09/20.
//

import UIKit

class CurrenciesDataSource: NSObject, UITableViewDataSource {
//    var viewModel: CurrencyListViewModel
    var currencies: [CurrencyModel]
    var dateExchange: Date?
    var didSelectCurrency: ((CurrencyModel) -> Void)?
    
    init(currencies: [CurrencyModel]) {
        self.currencies = currencies
        super.init()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CurrencyTableViewCell
        let currency = currencies[indexPath.row]
        cell.codeLabel.text = currency.code
        cell.nameLabel.text = currency.name

        if let valueDolar = currency.valueDollar {
            cell.toCurrencyLabel.text = currency.code
            cell.valueDollarLabel.text = "\(valueDolar)"
        }
        else {
            cell.toCurrencyLabel.text = ""
            cell.valueDollarLabel.text = ""
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let date = dateExchange else { return ""}
        return "Cotação de \(date.string)"
    }
}

extension CurrenciesDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        55
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard currencies.count > 0 else { return }
        let currency = currencies[indexPath.row]
//        let USD = Identifier.Currency.USD.rawValue
//        
//        if buttonTapped == .source {
//            converterViewModel.source = currency
//            if currency.code != USD {
//                converterViewModel.dollar = getDollar()
//            }
//        }
//        else if buttonTapped == .destiny {
//            converterViewModel.destiny = currency
//        }
        didSelectCurrency?(currency)
    }
//    
//    private func getDollar() -> CurrencyModel? {
//        let USD = Identifier.Currency.USD.rawValue
//        guard let index = currencies.firstIndex(where: { $0.code == USD }) else { return nil }
//        return currencies[index]
//    }
}
