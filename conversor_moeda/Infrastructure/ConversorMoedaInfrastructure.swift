//
//  ConversorMoedaInfrastructure.swift
//  conversor_moeda
//
//  Created by Eric Soares Filho on 27/08/20.
//  Copyright © 2020 erimia. All rights reserved.
//

import Foundation

class ConversorMoedaInfrastructure: ConversorMoedaInfrastructureProtocol {
    
    var apiGetAdapter: ApiGetAdapterProtocol = ApiGetAdapter()
    
    func getListaMoeda(completionHandler: @escaping(ListaMoedaResponse?, InfraError) -> Void) {
        apiGetAdapter.getSimpleApi(url: "http://api.currencylayer.com/list?access_key=07ea46708a1da6450c4e2a2704ae9740")
        { (resultData, error) -> Void in
            if error == .noError {
                let decoder = JSONDecoder()
                
                do {
                    let gitResponse = try decoder.decode(ListaMoedaResponse.self, from: resultData!)
                    completionHandler(gitResponse, .noError)
                } catch {
                    completionHandler(nil, .convertionJsonError)
                }
                
            } else {
                completionHandler(nil, .genericError)
            }
        }
    }
    
    func getListaCotacaoMoeda(completionHandler: @escaping(ListaMoedaCotacaoResponse?, InfraError) -> Void) {
        apiGetAdapter.getSimpleApi(url: "http://api.currencylayer.com/live?access_key=07ea46708a1da6450c4e2a2704ae9740")
        { (resultData, error) -> Void in
            if error == .noError {
                let decoder = JSONDecoder()
                
                do {
                    let gitResponse = try decoder.decode(ListaMoedaCotacaoResponse.self, from: resultData!)
                    completionHandler(gitResponse, .noError)
                } catch {
                    completionHandler(nil, .convertionJsonError)
                }
                
            } else {
                completionHandler(nil, .genericError)
            }
            
            
        }
    }
}
