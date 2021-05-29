//
//  TabBarController.swift
//  ConversorBTG
//
//  Created by Filipe Lopes on 21/11/20.
//

import UIKit

///Classe de controlle da Tabbar
class TabBarController: UITabBarController {
    
    //MARK: Atributos
    ///Referência das moedas
    var allCurrencies = [Currency]()
    
    //MARK: Métodos
    
    /**
     Método de inicialização pós carregamento da View
     - Warning: ⚠️Após inicializada, a tela irá salvar a referência de todas as moedas recebidas pós request na tela inicial
     - Parameters: none
     - Returns: none
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        self.saveCoreData()
    }
    
    /**
     Método para salvar as moedas no core data
     - Warning: ⚠️As moedas a serem salvas serão as moedas armazenadas na variável da classe
     - Parameters: none
     - Returns: none
     */
    private func saveCoreData(){
        let currencyDM = CurrencyDataManager()
        if currencyDM.readData().count == 0{
            currencyDM.createData(currencies: self.allCurrencies)
        }else{
            currencyDM.updateData(currencies: self.allCurrencies)
        }
    }
}

