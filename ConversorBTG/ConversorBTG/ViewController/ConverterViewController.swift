//
//  ConverterViewController.swift
//  ConversorBTG
//
//  Created by Filipe Lopes on 21/11/20.
//

import UIKit

///Classe que descreve a tela de conversão de moedas
class ConverterViewController: UIViewController{
    
    //MARK: Atributos
    
    ///TextField para se inserir o valor que será convertido
    @IBOutlet weak var currencyValueTextField: UITextField!
    ///Imagem de fundo da primeira PickerView
    @IBOutlet weak var firstCurrencyImageView: UIImageView!
    ///Imagem de fundo da segunda PickerView
    @IBOutlet weak var secondCurrencyImageView: UIImageView!
    ///Primeira pickerView que permitirá a escolha da primeira moeda
    @IBOutlet weak var firstCurrencyPickerView: UIPickerView!
    ///Segunda pickerView que permitirá a escolha da segunda moeda
    @IBOutlet weak var secondCurrencyPickerView: UIPickerView!
    ///Label que exibira o feedback da conversão
    @IBOutlet weak var resultlabel: UILabel!
    ///Referencia ao viewmodel
    let myViewModel = ConverterViewModel()
    
    //MARK: Métodos
    
    /**
     Método de inicialização pós carregamento da View
     - Warning: none
     - Parameters:none
     - Returns: none
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.myViewModel.valueEditingChanged(label: self.resultlabel, value: self.currencyValueTextField.text!)
        
        //caso não haja acesso a internet ou a requisição tenha sido falhada e não haja dados no banco
        if myViewModel.getAllCurerncies().count == 0{
            self.resultlabel.text = "Sem acesso a internet!"
        }
    }
    
    /**
     Ação de Botão que atualizará a label de acordo com mudanças no textField
     - Warning: none
     - Parameters:none
     - Returns: none
     */
    @IBAction func valueEditingChanged(_ sender: Any) {
        self.myViewModel.valueEditingChanged(label: self.resultlabel, value: self.currencyValueTextField.text!)
    }
    
}
