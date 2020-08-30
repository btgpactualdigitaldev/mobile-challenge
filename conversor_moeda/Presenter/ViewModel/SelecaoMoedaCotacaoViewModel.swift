//
//  SelecaoMoedaCotacaoViewModel.swift
//  conversor_moeda
//
//  Created by Eric Soares Filho on 27/08/20.
//  Copyright © 2020 erimia. All rights reserved.
//

import Foundation

struct SelecaoMoedaCotacaoViewModel {
    var valorCalculado: Double?
    
    init(valorCalculado: Double) {
        self.valorCalculado = valorCalculado
    }
}
