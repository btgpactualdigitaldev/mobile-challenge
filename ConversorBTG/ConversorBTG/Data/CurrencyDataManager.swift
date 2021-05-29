//
//  CurrencyDataManager.swift
//  ConversorBTG
//
//  Created by Filipe Lopes on 21/11/20.
//

import UIKit
import CoreData

///Classe para administrar a conexão com o Core Data
class CurrencyDataManager {
    
    //MARK: Atributos
    
    ///Constante com o nome da entidade do Banco
    private let entityName = "CurrencyEntity"
    
    //MARK: Métodos
    //CRUD - (Create, Read, Update, Delete)
    
    /**
     Método que salva um novo arrey de moedas dentro do Core Data.
     - Warning: ⚠️Caso chame essa função para um arrauy que já está salvo, ele ficrá duplicado.
     - Parameters:
        - currencies:[Currency] - Array de moedas que serão salvas no Core Data
     - Returns:
        - none.
     */
    func createData(currencies: [Currency]){

        //Configuração para pegar o contexto da View.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{ return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Recebendo a referencia a tabela de Moedas
        let currencyEntity = NSEntityDescription.entity(forEntityName: self.entityName, in: managedContext)!
        
        //Para cada moeda do array, serão salvos seus atributos no Core Data.
        for currency in currencies{
            let newCurrency = NSManagedObject(entity: currencyEntity, insertInto: managedContext)
            newCurrency.setValue(currency.name, forKey: "name")
            newCurrency.setValue(currency.id, forKey: "id")
            newCurrency.setValue(currency.value, forKey: "value")
        }
        
        //Do - Catch para tentar salvar o contexto (as mudanças no Core Data)
        do{
            try managedContext.save()
        }catch let error as NSError{
            print("Não foi possível salvar - Erro: \(error)")
        }
    }
    
    /**
     Método que busca do banco todos o dados da tabela CurrencyEntity.
     - Warning: ⚠️Ele busca sempre TODOS os dados da tabela.
     - Parameters:
        - none
     - Returns:
        - [Currency]: O método retorna um arrey de Currency com todas as moedas salvas no banco.
     */
    func readData()->[Currency]{
        var currencies = [Currency]()
        
        //Configuração para pegar o contexto da View.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{ return currencies }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Recebendo a referencia a tabela de Moedas
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: self.entityName)
        
        //Do - Catch para tentar buscar os dados do Core Date
        do{
            let result = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            
            //Par cara valor encontrado no banco, será criado um objeto e anexado na variável array de retorno.
            for data in result{
                let name = data.value(forKey: "name") as! String
                let id = data.value(forKey: "id") as! String
                let value = data.value(forKey: "value") as! Float
                currencies.append(Currency(name: name, id: id, value: value))
            }
        }catch let error as NSError{
            print("Erro ao buscar os dados do coreData - Erro: \(error)")
        }
        return currencies
    }
    
    /**
     Método que atualiza os dados do banco.
     - Warning: ⚠️Caso haja uma moeda que ainda não existe no banco, ela será ignorada. Utilize o createData(currencies:) para salvar novas moedas.
     - Parameters:
        - currencies:[Currency] - Array de moedas que serão atualizadas no Core Data
     - Returns:
        - none.
     */
    func updateData(currencies: [Currency]){
        
        //Configuração para pegar o contexto da View.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{ return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Recebendo a referencia a tabela de Moedas
        let fetchRequest : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: self.entityName)
        
        //Para cadamoeda será realizado o processo de atualização
        for currency in currencies{
            fetchRequest.predicate = NSPredicate(format: "id = %@", currency.id)
            do{
                let requestObject = try managedContext.fetch(fetchRequest)
                
                //Caso não ache a moeda, passará para a próxima
                if requestObject.count > 0{
                    let currencyToUpdate = requestObject[0] as! NSManagedObject
                    currencyToUpdate.setValue(currency.name, forKey: "name")
                    currencyToUpdate.setValue(currency.value, forKey: "value")
                }
                
                //Do - Catch para tentar salvar o contexto (as mudanças no Core Data)
                do{
                    try managedContext.save()
                }catch let error as NSError{
                    print("Erro ao salvar o contexto dos dados no coreData - Erro: \(error)")
                }
            }catch {
                print("Erro ao tentar buscar um dado específico no coreData ")
            }
        }
    }
    
    /**
     Método que eleta uma moeda do Core Data.
     - Warning: ⚠️Atenção ao deletar um dado, tenha certeza da operação.
     - Parameters:
        - currency:Currency- Instância da moeda que será deletada do banco.
     - Returns:
        - none.
     */
    func delete(currency: Currency){
        
        //Configuração para pegar o contexto da View.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{ return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Recebendo a referencia a tabela de Moedas
        let fetchRequest : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: self.entityName)
        fetchRequest.predicate = NSPredicate(format: "id = %@", currency.id)
        
        //Do - Catch para tentar achar a moeda no banco
        do{
            let requestObject = try managedContext.fetch(fetchRequest)
            let currencyToDelete = requestObject[0] as! NSManagedObject
            managedContext.delete(currencyToDelete)
            
            //Do - Catch para tentar salvar o contexto (as mudanças no Core Data)
            do{
                try managedContext.save()
            }catch let error as NSError{
                print("Erro ao salvar o contexto dos dados no coreData - Erro: \(error)")
            }
        }catch{
            print("Erro ao tentar buscar um dado específico no coreData ")
        }
    }
}
