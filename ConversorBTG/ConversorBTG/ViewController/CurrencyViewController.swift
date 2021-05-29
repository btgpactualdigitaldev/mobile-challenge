//
//  CurrencyViewController.swift
//  ConversorBTG
//
//  Created by Filipe Lopes on 21/11/20.
//

import UIKit

///Classe que armazena e descreve a view que mostrará todas as moedas
class CurrencyViewController: UIViewController {
    
    //MARK: Atributos
    
    ///Referência da tableview
    @IBOutlet weak var currencyTableView: UITableView!
    ///TextField para a pesquisa da moeda
    @IBOutlet weak var searchTextField: UITextField!
    
    ///Referência ao viewModel
    let myViewModel = CurrencyViewModel()
    
    //MARK: Métodos
    
    /**
     Método de inicialização pós carregamento da View
     - Warning: none
     - Parameters:none
     - Returns: none
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        //Método que permite que o teclado recue ao reconhecer um toque na tela
        self.hideKeyboardWhenTappedAround()
    }
    
    /**
     Método a ser chamado sempre que a tela aparecer vindo de outra tela para atualizar a tabela
     - Warning: none
     - Parameters:none
     - Returns: none
     */
    override func viewDidAppear(_ animated: Bool) {
        self.myViewModel.attCurrencies()
        self.currencyTableView.reloadData()
    }
    
    /**
     Ação de um botão quando o texto da textField detecta alguma mudança
     - Warning: ⚠️Essa ação será chamada sempre que ocorrer qualquer mudança no textfield
     - Parameters:none
     - Returns: none
     */
    @IBAction func editingChanged(_ sender: Any) {
        self.myViewModel.textFieldChanged(text: self.searchTextField.text!)
        self.currencyTableView.reloadData()
    }
}
