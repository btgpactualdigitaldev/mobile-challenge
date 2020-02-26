//
//  ConversionAPIStore.swift
//  DesafioBTG
//
//  Created by Robson Moreira on 19/02/20.
//  Copyright © 2020 Robson Moreira. All rights reserved.
//

import Alamofire

class ConversionAPIStore: GenericAPIStore, ConversionStore {
    
    func getQuotes(parameters: [String : Any], completion: @escaping (Conversion.Quotes.Response?, Error?) -> Void) {
        do {
            var paras = parameters
            paras["access_key"] = API.key
            
            let urlRequest = try ConversionNetworkRouter.live.asURLRequest()
            if let url = urlRequest {
                Alamofire.request(url, method: .get, parameters: paras, encoding: URLEncoding.queryString).responseJSON { response in
                    switch response.result {
                    case .success:
                        guard let json = response.data else {
                            completion(nil, self.error)
                            return
                        }
                        
                        do {
                            let result = try JSONDecoder().decode(Conversion.Quotes.Response.self, from: json)
                            completion(result, nil)
                        } catch {
                            completion(nil, error)
                        }
                    case .failure(let error):
                        completion(nil, error)
                    }
                    
                }
            }
        } catch let error {
            completion(nil, error)
        }
    }
    
}
