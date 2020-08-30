//
//  ApiGetAdapter.swift
//  conversor_moeda
//
//  Created by Eric Soares Filho on 27/08/20.
//  Copyright © 2020 erimia. All rights reserved.
//

import Foundation

class ApiGetAdapter: ApiGetAdapterProtocol {
    func getSimpleApi(url: String, completionHandler: @escaping(Data?, AdapterErro) -> Void) {
           let urlString = url
           if let url = URL(string: urlString)
           {
               URLSession.shared.dataTask(with: url){ data, res, err in
                   if let data = data {
                       completionHandler(data, .noError)
                   } else {
                       completionHandler(nil, .genericError)
                   }
               }.resume()
           }
    }
}


