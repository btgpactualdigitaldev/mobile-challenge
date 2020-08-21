//
//  MyRequest.swift
//  AppCambio
//
//  Created by Visão Grupo on 8/21/20.
//  Copyright © 2020 Vinicius Teixeira. All rights reserved.
//

import Foundation

class MyRequest: NSObject, URLSessionDelegate, URLSessionDataDelegate, URLSessionTaskDelegate {
    
    func dataTask(_ urlString: String, callBack: @escaping (Data?, URLResponse?, Error?) -> Void) {
        
        guard Reachability.isConnectedToNetwork() else {
            Helper.alertController("Atenção", message: "Você precisa estar conectado a internet.")
            return
        }
        
        guard let url = URL(string: urlString) else {
            print("MyRequest->dataTask: Essa não é uma URL válida para requisição.")
            return
        }
        
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 20.0)
        request.httpMethod = "GET"
        let session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
        let task = session.dataTask(with: url, completionHandler: callBack)
        task.resume()
    }
}
