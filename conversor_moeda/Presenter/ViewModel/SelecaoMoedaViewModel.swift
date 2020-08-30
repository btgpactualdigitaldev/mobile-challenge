//
//  SelecaoMoedaViewModel.swift
//  conversor_moeda
//
//  Created by Eric Soares Filho on 26/08/20.
//  Copyright © 2020 erimia. All rights reserved.
//

import Foundation

struct SelecaoMoedaViewModel {
    var moeda: String?
    var sigla: String?
    
    init(moeda: String, sigla: String) {
        self.moeda = moeda
        self.sigla = sigla
    }
}


