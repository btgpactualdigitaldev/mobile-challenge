//
//  CurrencyListPresenter.swift
//  Conversor de moedas
//
//  Created by Matheus Duraes on 21/12/20.
//

import Foundation

protocol CurrencyListPresenterView: class {
    func loadTableView(currenciesArray: [CurrencyResult])
}

class CurrencyListPresenter {
    weak var view: CurrencyListPresenterView?
    var currenciesArray: [CurrencyResult] = [CurrencyResult]()
    
    init(with view: CurrencyListPresenterView) {
        self.view = view
    }
    
    func getList(){
        let url = URL(string: Constants.BASE_URL+"list?access_key="+Constants.ACCESS_KEY+"&format=1")
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error == nil {
                do {
                    let result = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any]
                    let dictCurrencies : [String : String] = result!["currencies"] as! [String : String]
                    for (key, value) in dictCurrencies {
                        self.currenciesArray.append(CurrencyResult(code: key, description: value))
                    }
                    DispatchQueue.main.async {
                        self.view?.loadTableView(currenciesArray: self.currenciesArray)
                    }
                } catch {
                    print("Error parse JSON: \(error.localizedDescription)")
                }
            }
        }
        task.resume()
    }
    
}
