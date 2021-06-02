//
//  MainPresenter.swift
//  Conversor de moedas
//
//  Created by Matheus Duraes on 21/12/20.
//

import Foundation

protocol MainPresenterView: class {
    func setResultLabel(text: String)
    func showMsgError(msg: String)
    func getValueString() -> String
    func showProgress()
    func hideProgress()
    func resetSource()
}

class MainPresenter {
    weak var view: MainPresenterView?
    
    init(with view: MainPresenterView) {
        self.view = view
    }
    
    func convertCurrency(fromCode: String, fromDescription: String, toCode: String, toDescription: String){
        view?.showProgress()
        var valueFrom: Double = 0.0
        var valueTo: Double = 0.0
        let url = URL(string: Constants.BASE_URL+"live?access_key="+Constants.ACCESS_KEY+"&currencies=USD,"+fromCode+","+toCode+"&format=1")
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error == nil {
                do {
                    let result = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any]
                    if (!((result?["success"]) != nil) == true){
                        DispatchQueue.main.async {
                            self.view?.hideProgress()
                            self.view?.showMsgError(msg: "Houve um problema ao buscar os dados, tente novamente mais tarde.")
                        }
                    } else {
                        let dictCurrencies : [String : Double] = result!["quotes"] as! [String : Double]
                        for (key, value) in dictCurrencies {
                            if (key == "USD"+fromCode) {
                                valueFrom = Double(value)
                            } else if(key == "USD"+toCode){
                                valueTo = Double(value)
                            }
                        }
                        DispatchQueue.main.async {
                            self.view?.hideProgress()
                            let valueScreen = Double(self.valueIsConvert())
                            let valueDouble = (valueTo / valueFrom) * valueScreen
                            let value2decimal = String(format: "%.2f", valueDouble)
                            
                            var resultString = "Resultado: " + String(value2decimal)
                            resultString += " " + toCode
                            resultString += " - " + toDescription
                            
                            self.view?.setResultLabel(text: resultString)
                            self.view?.resetSource()
                        }
                    }
                } catch {
                    print("Error parse JSON: \(error.localizedDescription)")
                }
            }
        }
        task.resume()
    }
    
    func valueIsConvert() -> Float {
        let value = view?.getValueString()
        return Float(value!.replacingOccurrences(of: ",", with: ".")) ?? 0.0
    }
    
    func validConvert(from: String, to: String) -> Bool {
        if (from.isEmpty && to.isEmpty) {
            view?.showMsgError(msg: "Selecione as moedas antes de efetuar a conversão")
            return false
        } else if(from.isEmpty) {
            view?.showMsgError(msg: "Selecione uma moeda de origem antes de efetuar a conversão.")
            return false
        } else if(to.isEmpty) {
            view?.showMsgError(msg: "Selecione uma moeda de destino antes de efetuar a conversão.")
            return false
        } else {
            if(view?.getValueString() == ""){
                view?.showMsgError(msg: "Informe um valor para converter!")
                return false
            }
            return true
        }
    }
}
