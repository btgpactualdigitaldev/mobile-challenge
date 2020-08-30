//
//  SelectedMoedasConversaoSingleton.swift
//  conversor_moeda
//
//  Created by Eric Soares Filho on 27/08/20.
//  Copyright © 2020 erimia. All rights reserved.
//

import Foundation


struct SelectedMoedasConversaoSingleton {
    static var moeda1: String?
    static var moeda2: String?
    static var selectMoeda: selectMoeda?
}

enum selectMoeda {
    case deMoeda
    case paraMoeda
}
