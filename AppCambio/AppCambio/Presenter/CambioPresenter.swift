//
//  CambioPresenter.swift
//  AppCambio
//
//  Created by Visão Grupo on 8/21/20.
//  Copyright © 2020 Vinicius Teixeira. All rights reserved.
//

import Foundation

protocol CambioViewToPresenter: class {
    var view: CambioPresenterToView? {get set}
    func getQuotes(_ from: String, to: String)
    func calculate(_ from: String, to: String, value: Double)
}

class CambioPresenter: CambioViewToPresenter {
    
    // MARK: Properties
    
    var view: CambioPresenterToView?
    let cambioDAO = CambioDAO()
    
    
    // MARK: CambioViewToPresenter
    
    func calculate(_ from: String, to: String, value: Double) {
        do {
            let cambios = try cambioDAO.selectAll()
            var valueFrom: Double = 0.0
            var valueTo: Double = 0.0
            for cambio in cambios {
                if cambio.identificador == "USD\(from)" {
                    valueFrom = cambio.valor
                } else if cambio.identificador == "USD\(to)" {
                    valueTo = cambio.valor
                }
            }
            valueTo = (valueTo/valueFrom)*value
            view?.returnValue(valueTo)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getQuotes(_ from: String, to: String) {
        MyRequest().dataTask("http://api.currencylayer.com/live?access_key=d0a9d5146e31758ce39616fce1e99c2f&currencies=\(from),\(to)", callBack: {(receivedData, urlResponse, error) in
            if let errorAux = error {
                print("CambioPresenter->convert: \(errorAux.localizedDescription)")
            }
                            
            guard let httpResponse = urlResponse as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("CambioPresenter->convert: Não foi possível obter dados da requisição.")
                return
            }
            
            guard let data = receivedData else {
                print("CambioPresenter->convert: Não foi possível obter dados da requisição.")
                return
            }
            
            do {
                print(String(data: data, encoding: .utf8)!)
                let decoder = JSONDecoder()
                let cambioMapper = try decoder.decode(CambioMapper.self, from: data)
                for cambio in cambioMapper.quotes {
                    try self.cambioDAO.deleteBy(cambio.key)
                    self.cambioDAO.insert(cambio.key, valor: cambio.value)
                }
                CoreDataManager.saveContextOnMainThead()
            } catch {
                print(error.localizedDescription)
            }
        })
    }
}

protocol CambioPresenterToView: class {
    func returnValue(_ value: Double)
}
