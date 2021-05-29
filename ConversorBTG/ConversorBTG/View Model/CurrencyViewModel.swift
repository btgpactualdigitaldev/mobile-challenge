//
//  CurrencyViewModel.swift
//  ConversorBTG
//
//  Created by Filipe Lopes on 21/11/20.
//

import UIKit

///Classe que gerencia a relação entre a CurrencyView e o modelo Currency
class CurrencyViewModel {
    
    //MARK: Atributos
    
    ///Variável que armazena todas as instâncias das moedas
    var allCurrencies =  [Currency]()
    ///Constante de referência para o banco.
    private let currencyDM = CurrencyDataManager()
    
    //MARK: Métodos
    
    /**
     Método construtor do ViewModel
     - Warning: ⚠️Ao ser instanciado, o viewModel já busca todas as moedas no Core data e as ordena.
     - Parameters: none
     - Returns:
        - CurrencyViewModel
     */
    init(){
        self.allCurrencies = currencyDM.readData()
        self.ordenate()
    }
    
    /**
     Método para atualizar as moedas, buscando no banco de dados.
     - Warning: none
     - Parameters: none
     - Returns: none
     */
    func attCurrencies(){
        self.allCurrencies = currencyDM.readData()
        self.ordenate()
    }
    
    /**
     Método para popular a célula da tableView
     - Warning: none
     - Parameters:
        - tableView: UITableView - Referencia para a tabela que está sendo populada
        - indexPath: IndexPath - Index para saber qual célula se está criando
     - Returns:
        - UITableViewCell - Retorna a célula da tabela pronta.
     */
    func setupTableView(tableView: UITableView, indexPath: IndexPath)-> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "currencyCell") as! CurrencyTableViewCell
        
        //Caso não tenha dados no banco avisa-se que não possui conexão
        if self.allCurrencies.count == 0 {
            cell.currencyName.text = "Sem acesso a internet"
            cell.currencyId.text = ""
            return cell
        }
        
        let currency = allCurrencies[indexPath.row]
        
        //Configurando os atributos da célula
        cell.currencyName.text = currency.name
        cell.currencyId.text = currency.id
        let value = CGFloat(currency.value)
        let valueString = String(format: "%.4f", value)
        cell.currencyValue.text = "USD: \(valueString)"
        cell.currencyImageView.image = UIImage(named: currency.id) ?? UIImage(systemName: "dollarsign.circle" )
        
        return cell
    }
    
    /**
     Método para identificar quando o campo de texto mudar
     - Warning: none
     - Parameters: text: String - Texto do textField
     - Returns: none
     */
    func textFieldChanged(text: String){
        
        //Atualiza a referencia a todas as moedas.
        self.allCurrencies = currencyDM.readData()
        
        //Se a busca estiver vazia, retornar todos os elementos
        if text == ""{
            return
        }else{
            //Filtra verificando se o campo de busca está preente no nome ou no id da moeda
            var auxCurrencies = [Currency]()
            for item in allCurrencies{
                let itemNameLower = item.name.lowercased()
                let itemIdLower =  item.id.lowercased()
                let textLower = text.lowercased()
                if itemNameLower.contains(textLower) || itemIdLower.contains(textLower){
                    auxCurrencies.append(item)
                }
            }
            
            //Feedback quando a busca não retornar algum valor
            if auxCurrencies.count == 0{
                auxCurrencies.append(Currency(name: "Valor não encontrado", id: "??", value: 0.0))
            }
            self.allCurrencies = auxCurrencies
        }
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
}
