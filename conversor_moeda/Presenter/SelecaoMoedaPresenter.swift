//
//  SelecaoMoedaPresenter.swift
//  conversor_moeda
//
//  Created by Eric Soares Filho on 26/08/20.
//  Copyright © 2020 erimia. All rights reserved.
//

import Foundation

class SelecaoMoedaPresenter: SelecaoMoedaPresenterProtocol {
    
    var conversorMoedaInfrastructure: ConversorMoedaInfrastructureProtocol = ConversorMoedaInfrastructure()
    
    func carregarDadosDeMoedas(completionHandler: @escaping ([SelecaoMoedaViewModel], PresenterError) -> Void) {
        
        var list: [SelecaoMoedaViewModel] = []
        
        conversorMoedaInfrastructure.getListaMoeda() {
            (resultData, error) -> Void in
            if error == .noError {
                    let sortedValues = resultData?.currencies
                    
                    let valueOrdered = sortedValues!.sorted(by: {
                        return $0.key < $1.key
                })
                
                valueOrdered.forEach{
                    list.append(SelecaoMoedaViewModel(moeda: $0.value, sigla: $0.key))
                }
                completionHandler(list, .noError)
            } else {
                completionHandler(list, .genericError)
            }
        }
    }
    
    
    func carregarDadosDeMoedasCotacao(deMoeda: String?, paraMoeda: String?, valor: Double?, completionHandler: @escaping (Double?, PresenterError) -> Void) {
        
        var valorResultado = 0.0
        
        
        conversorMoedaInfrastructure.getListaCotacaoMoeda(){
            (resultData, error) -> Void in
            if error == .noError {
                resultData?.quotes!.forEach{
                    if "USD\(deMoeda!)" == $0.key {
                        valorResultado = valor! / $0.value
                    }
                }
                
                resultData?.quotes!.forEach{
                    if "USD\(paraMoeda!)" == $0.key {
                        valorResultado = valorResultado * $0.value
                    }
                }
                
                completionHandler(valorResultado, .noError)
            } else if error == .genericError || error == .convertionJsonError {
                completionHandler(nil, .genericError)
            }
        }
    }
}
