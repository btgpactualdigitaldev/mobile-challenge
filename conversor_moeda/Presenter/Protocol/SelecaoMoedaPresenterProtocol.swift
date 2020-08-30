//
//  SelecaoMoedaPresenterProtocol.swift
//  conversor_moeda
//
//  Created by Eric Soares Filho on 27/08/20.
//  Copyright © 2020 erimia. All rights reserved.
//

import Foundation

protocol SelecaoMoedaPresenterProtocol {
    func carregarDadosDeMoedas(completionHandler: @escaping ([SelecaoMoedaViewModel], PresenterError) -> Void)
    func carregarDadosDeMoedasCotacao(deMoeda: String?, paraMoeda: String?, valor: Double?, completionHandler: @escaping (Double?, PresenterError) -> Void)
}
