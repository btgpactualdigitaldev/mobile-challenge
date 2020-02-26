//
//  CoinListingAPIStore.swift
//  DesafioBTG
//
//  Created by Robson Moreira on 17/02/20.
//  Copyright © 2020 Robson Moreira. All rights reserved.
//

import Alamofire

class CoinListingAPIStore: GenericAPIStore, CoinListingStore {
    
    func getCurrencies(completion: @escaping (CoinListing.Currencies.Response?, Error?) -> Void) {
        do {
            let urlRequest = try CoinListingNetworkRouter.list.asURLRequest()
            if let url = urlRequest {
                Alamofire.request(url, method: .get, parameters: ["access_key": API.key], encoding: URLEncoding.queryString).responseJSON { response in
                    switch response.result {
                    case .success:
                        guard let json = response.data else {
                            completion(nil, self.error)
                            return
                        }
                        
                        do {
                            let result = try JSONDecoder().decode(CoinListing.Currencies.Response.self, from: json)
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
