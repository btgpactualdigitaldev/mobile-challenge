//
//  ConversorMoedaInfrastructureProtocol.swift
//  conversor_moeda
//
//  Created by Eric Soares Filho on 27/08/20.
//  Copyright © 2020 erimia. All rights reserved.
//

import Foundation

protocol ConversorMoedaInfrastructureProtocol {
    func getListaMoeda(completionHandler: @escaping(ListaMoedaResponse?, InfraError) -> Void)
    func getListaCotacaoMoeda(completionHandler: @escaping(ListaMoedaCotacaoResponse?, InfraError) -> Void)
}
