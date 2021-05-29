//
//  CurrencyRequestStructs.swift
//  ConversorBTG
//
//  Created by Filipe Lopes on 21/11/20.
//

import Foundation

///Estrutura para receber a resposta da requisição de lista de moedas
struct ListResponse: Decodable{
    let success: Bool
    let terms: String
    let privacy: String
    let currencies: Dictionary<String, String>
}

///Estrutura para receber a resposta da requisição de lista de valres das moedas
struct LiveResponse: Decodable{
    let quotes: Dictionary<String, Float>
    let terms: String
    let privacy: String
    let success : Bool
}
