//
//  ApiDataManager.swift
//  ConversorBTG
//
//  Created by Filipe Lopes on 21/11/20.
//

import UIKit

///Classe para gerenciar as duas requisições da API.
class ApiDataManager {
    
    //MARK: Atributos
    
    ///URL par a requisição dos valores das moedas em relação ao dólar
    private let apiLiveURL = "http://api.currencylayer.com/live?access_key=b3f2bb8843cddc310192edc2b81ad75b"
    ///URL par a requisição das moedas e das suas siglas
    private let apiListURL = "http://api.currencylayer.com/list?access_key=b3f2bb8843cddc310192edc2b81ad75b"
    
    ///Variável que armazenará todas as instâncias de todas as moedas.
    var allCurrencies = [Currency]()
    
    ///Dicionário para receber o Dicionário em JSON da requisição <SiglaDaMoeda : NomeDaMoeda>
    private var currencies = Dictionary<String, String>()
    ///Dicionário para receber o Dicionário em JSON da requisição <SiglaDaMoeda : ValorDaMoeda>
    private var quotes = Dictionary<String, Float>()
    
    ///Variável para comunicar quando a requisição terminará
    private var delegate : APIEnded?
    
    //MARK: Métodos
    
    /**
     Método construtor .
     - Warning: ⚠️Assim que instanciado, a requisição iniciará.
     - Parameters:
        - delegate: APIEnded - Objeto que entra em conformidade com o Protocolo APIEnded, para receber o array de medas quando a requisição acabar.
     - Returns:
        - ApiDataManager: Uma instância da classe.
     */
    init(delegate: APIEnded) {
        self.delegate = delegate
        //Inicia-se a primeira requisição
        self.getCurrencyList{ (listResponse, error) in
            //⚠️Caso ocorra algum erro, a requisição para.
            if let error = error{
                print("Não foi possível fazer a requisição da lista.", error)
                return
            }
            //Dicionário recebe o resulado da requisição
            self.currencies = listResponse!.currencies
            //Inicia-se a seguda requisição
            //⚠️Ela só se inicia se a primeira funcinar (para um maior controle na criação dos objetos).
            self.getCurrencyLive{ (liveResponse, error) in
                if let error = error{
                    //⚠️Caso ocorra algum erro, a requisição para.
                    print("Não foi possível fazer a requisição dos valores.", error)
                    return
                }
                //Dicionário recebe o resultado da requisição
                self.quotes = liveResponse!.quotes
                
                //chama o método que irá mapear os dicionários em Objetos.
                self.mapCurrencies()
            }
        }
    }
    
    /**
     Método faz a requisição da lista das moedas e suas siglas.
     - Warning: ⚠️Essa função PODE retornar uma resposta ou um erro em seu @escaping.
     - Parameters:
        - completion:@escaping (ListResponse?, Error?) - função que irá dizer o que fazer assim que a requisição terminar.
     - Returns:
        - (ListResponse?, Error?): Dictionary, Error - É passado como parâmetro ao completion o resultado ou um erro.
     */
    private func getCurrencyList(completion: @escaping (ListResponse?, Error?) ->()){
        
        //cria um URL a partir da String com o url da requisição mais a chave de acesso
        guard let url = URL(string: self.apiListURL) else{
            return
        }
        
        //inicia a requisição
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            //se ocorrer algum erro, a requisição acaba
            if let error = error{
                completion(nil, error)
                return
            }
            //Do - Catch para tentar decodificar o dado resposta.
            do{
                let list = try JSONDecoder().decode(ListResponse.self, from: data!)
                completion(list, nil)
            }catch let error{
                completion(nil, error)
                return
            }
        }.resume()
    }
    
    /**
     Método faz a requisição da lista das moedas e seus valores.
     - Warning: ⚠️Essa função PODE retornar uma resposta ou um erro em seu @escaping.
     - Parameters:
        - completion:@escaping (ListResponse?, Error?) - função que irá dizer o que fazer assim que a requisição terminar.
     - Returns:
        - (LiveResponse?, Error?): Dictionary, Error - É passado como parâmetro ao completion o resultado ou um erro.
     */
    private func getCurrencyLive(completion: @escaping (LiveResponse?, Error?)-> ()){
        
        //cria um URL a partir da String com o url da requisição mais a chave de acesso
        guard let url = URL(string: self.apiLiveURL) else{
            return
        }
        
        //inicia a requisição
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            //se ocorrer algum erro, a requisição acaba
            if let error = error{
                completion(nil, error)
                return
            }
            
            //Do - Catch para tentar decodificar o dado resposta.
            do{
                let liveList = try JSONDecoder().decode(LiveResponse.self, from: data!)
                completion(liveList, nil)
            }catch let error{
                completion(nil, error)
                return
            }
        }.resume()
    }
    
    /**
     Método para mapear os dicionários em objetos Currency.
     - Warning: ⚠️Assim que o mapeamento acabar, ele acionará o delegate passando o array allCurrencies: [Currency].
     - Parameters:none
     - Returns: none
     */
    private func mapCurrencies(){
        
        //Para cada item dentro do dicionário de <sigla: Moeda>
        for item in self.currencies{
            
            //A sigla na segunda requisição vem com um USD na frente (indicando que o valor é em relação ao dólar).
            let usdKey = "USD\(item.key)"
            let currency = Currency(name: item.value, id: item.key, value: self.quotes[usdKey]!)
            self.allCurrencies.append(currency)
        }
        delegate?.reload(allCurrencies: self.allCurrencies)
    }
}
