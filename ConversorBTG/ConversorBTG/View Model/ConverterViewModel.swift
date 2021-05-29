//
//  ConverterViewModel.swift
//  ConversorBTG
//
//  Created by Filipe Lopes on 21/11/20.
//

import UIKit

///Classe que gerencia a relação entre a ConverterView e o modelo Currency
class ConverterViewModel{
    
    //MARK: Atributos
    
    ///Rerefencia para todas as moedas
    private var allCurrencies = [Currency]()
    ///Constante de referência para o banco.
    private let currecyDM = CurrencyDataManager()
    
    ///Referencia ao pickerview que selecionará a moeda base
    var firstPickerViewCurrency : Currency
    ///Referencia ao pickerview que selecionará a moeda a ser convertida
    var secondPickerViewCurrency : Currency
    
    //MARK: Métodos
    
    /**
     Método construtor que realizará as configuações iniciais do viewModel
     - Warning: none
     - Parameters: none
     - Returns: ConverterViewModel - Instância da Classe
     */
    init() {
        self.allCurrencies = currecyDM.readData()
        self.firstPickerViewCurrency = Currency(name: "", id: "", value: 1.0)
        self.secondPickerViewCurrency = Currency(name: "", id: "", value: 1.0)
        if self.allCurrencies.count > 0{
            self.ordenate()
            self.firstPickerViewCurrency = allCurrencies[0]
            self.secondPickerViewCurrency = allCurrencies[0]
        }
    }
    
    /**
     Método para buscar todas as moedas no banco de dados
     - Warning: none
     - Parameters: none
     - Returns: [Currency] - Array ordenado com todas as moedas
     */
    func getAllCurerncies()->[Currency]{
        self.allCurrencies = currecyDM.readData()
        self.ordenate()
        return self.allCurrencies
    }
    
    /**
     Método para configurar ambas as pickerViews da View.
     - Warning: ⚠️Como são duas pickerViews, necessita da referincia da classe a cada uma delas para se diferencias ao cria-las (no nosso caso não é tão importante porque elas são iguais).
     - Parameters:
        - firstPV: UIPickerView - Referencia a uma das pickerviews, para se saber com qual des se está trabalhando.
        - pickerView: UIPickerView -  a picker view que se está sendo populada.
        - row:Int - Linha específica que estamo configurando
     - Returns: String - Título da linha da pickerview
     */
    func setupPickerViewItems(firstPV: UIPickerView, pickerView: UIPickerView, row: Int)->String{
        if pickerView == firstPV{
           return "\(self.allCurrencies[row].name) - \(self.allCurrencies[row].id)"
        }else{
            return "\(self.allCurrencies[row].name) - \(self.allCurrencies[row].id)"
        }
    }
    
    /**
     Método realizar alterações na view de acordo com a mudança no textfield do valor a ser convertido
     - Warning: ⚠️Caso o valor do textfield não seja possível de se converter para float, a função retornará
     - Parameters:
        - label: UILabel - Label que receberá o feedback do cálculo
        - value: String - Valor de primeira moeda a ser convertida vinda do TextField
     - Returns: none
     */
    func valueEditingChanged(label: UILabel, value: String){
        
        //Converte o valor em Float
        guard let floatValue = Float(value) else {
            return
        }
        
        let resultValue = floatValue * (firstPickerViewCurrency.value / secondPickerViewCurrency.value)
        
        let resultText = String(format: "%.2f", resultValue)
        
        label.text = "\(floatValue) \(self.firstPickerViewCurrency.name) - \(self.firstPickerViewCurrency.id) = \(resultText)  \(self.secondPickerViewCurrency.name) - \(self.secondPickerViewCurrency.id)"
    }
    
    /**
     Método para ordenar o array com todas as moedas
     - Warning: none
     - Parameters: none
     - Returns: none
     */
    private func ordenate()  {
        self.allCurrencies.sort {
            $0.name < $1.name
        }
    }
    
    /**
     Método realizar alterações na view de acordo com a mudança em alguma PickerView
     - Warning: none
     - Parameters:
        - firstPv: Bool - Variável para saber qual pickerview foi alterada
        - row: Int - Linha que está atualmente selecionada
        - imageView: UIImageView  - Referencia á imagem de fundo do pickerview
     - Returns: none
     */
    func changePickerView(firstPv: Bool, row: Int, imageView: UIImageView){
        if firstPv{
            self.firstPickerViewCurrency = allCurrencies[row]
            imageView.image = UIImage(named: firstPickerViewCurrency.id) ?? UIImage(systemName: "dollarsign.circle.fill")
        }else{
            self.secondPickerViewCurrency = allCurrencies[row]
            imageView.image = UIImage(named: secondPickerViewCurrency.id) ?? UIImage(systemName: "dollarsign.circle.fill")
        }
    }
}
