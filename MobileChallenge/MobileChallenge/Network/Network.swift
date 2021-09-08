//
//  Network.swift
//  MobileChallenge
//
//  Created by Vitor Gomes on 07/09/21.
//

import Foundation

typealias completion<T> = (_ result: T,_ failure: String?) -> Void

class Network {
    
    let session: URLSession = URLSession.shared
    
    func getListData(completion: @escaping completion<List?>) {
        
        let url: URL? = URL(string: NetworkResources.baseURL + NetworkResources.listRequest)
        
        if let url = url {
            let task: URLSessionTask = session.dataTask(with: url) { data, response, error in
                
                do {
                    let list = try JSONDecoder().decode(List.self, from: data ?? Data())
                    completion(list, nil)
                }catch{
                    print(error.localizedDescription)
                    print(error)
                    completion(nil, "Falha no parse")
                }
            }
            task.resume()
        }
    }
    
    func getLiveData(completion: @escaping completion<Live?>) {
        
        let url: URL? = URL(string: NetworkResources.baseURL + NetworkResources.liveRequest)
        
        if let url = url {
            let task: URLSessionTask = session.dataTask(with: url) { data, response, error in
                
                do {
                    let list = try JSONDecoder().decode(Live.self, from: data ?? Data())
                    completion(list, nil)
                }catch{
                    print(error.localizedDescription)
                    print(error)
                    completion(nil, "Falha no parse")
                }
            }
            task.resume()
        }
    }
    
    }

    
    

