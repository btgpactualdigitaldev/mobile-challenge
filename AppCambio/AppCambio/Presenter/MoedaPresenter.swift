//
//  MoedaPresenter.swift
//  AppCambio
//
//  Created by Visão Grupo on 8/21/20.
//  Copyright © 2020 Vinicius Teixeira. All rights reserved.
//

import Foundation

protocol MoedaViewToPresenter: class {
    var view: MoedaPresenterToView? {get set}
    func getData()
    func search(_ text: String)
}

class MoedaPresenter: MoedaViewToPresenter {
    
    // MARK: Properties
    
    var view: MoedaPresenterToView?
    var moedas: [Moeda] = []
    
    
    // MARK: Methods
    
    private func getDataFromRequest() {
        MyRequest().dataTask("http://api.currencylayer.com/list?access_key=d0a9d5146e31758ce39616fce1e99c2f", callBack: {(receivedData, urlResponse, error) in
            do {
                if let errorAux = error {
                    print("MoedaPresenter->getDataFromRequest: \(errorAux.localizedDescription)")
                }
                
                guard let httpResponse = urlResponse as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    print("MoedaPresenter->getDataFromRequest: Não foi possível obter dados da requisição.")
                    return
                }
                
                guard let data = receivedData else {
                    print("MoedaPresenter->getDataFromRequest: Não foi possível obter dados da requisição.")
                    return
                }
                
//                print(String(data: data, encoding: .utf8)!)
                let decoder = JSONDecoder()
                let moeda = try decoder.decode(MoedaMapper.self, from: data)
                let moedaDAO = MoedaDAO()
                try moedaDAO.deleteAll()
                var moedas: [Moeda] = []
                for currency in moeda.currencies {
                    moedas.append(Moeda(currency.value, identificador: currency.key))
                    moedaDAO.insert(currency.value, identificador: currency.key)
                }
                self.moedas = moedas
                CoreDataManager.saveContextOnMainThead()
                DispatchQueue.main.async { self.view?.returnData(moedas) }
            } catch {
                print(error.localizedDescription)
            }
        })
    }
    
    private func getDataFromCoreData() {
        do {
            let moedaDAO = MoedaDAO()
            let moedas = try moedaDAO.selectAll()
            self.moedas = moedas
            view?.returnData(moedas)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    // MARK: MoedaViewToPresenter
    
    func getData() {
        Reachability.isConnectedToNetwork() ? getDataFromRequest() : getDataFromCoreData()
    }
    
    func search(_ text: String) {
        if text.isEmpty {
            view?.returnData(moedas)
        } else {
            var moedas: [Moeda] = []
            for moeda in self.moedas where moeda.descricao.lowercased().contains(text.lowercased()) || moeda.identificador.lowercased().contains(text.lowercased()) {
                moedas.append(moeda)
            }
            view?.returnData(moedas)
        }
    }
}

protocol MoedaPresenterToView: class {
    func returnData(_ moedas: [Moeda])
}
