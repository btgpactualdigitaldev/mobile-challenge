//
//  Currency.swift
//  ConversorBTG
//
//  Created by Filipe Lopes on 21/11/20.
//

import UIKit

///Classe que descreve o modelo da moeda
class  Currency {
    
    //MARK: Atributos
    ///Nome da moeda
    let name: String
    ///Sigla da moeda
    let id: String
    ///Valor da moeda em relação ao dólar
    let value: Float
    
    //MARK: Métodos
    
    /**
     Método consrtutor
     - Warning: ⚠️Essa função PODE retornar uma resposta ou um erro em seu @escaping.
     - Parameters:
        - name: String - Nome da Moeda (Ex: "Dólar")
        - id: String - Sigla da Moeda (Ex: "BRL")
        - value: Float - Valor da moeda em relação ao Dólar
     - Returns:
        - Currency: Instância da classe
     */
    init(name: String, id: String, value: Float) {
        self.name = name
        self.id = id
        self.value = value
    }
}
