//
//  ApiGetAdapterProtocol.swift
//  conversor_moeda
//
//  Created by Eric Soares Filho on 27/08/20.
//  Copyright © 2020 erimia. All rights reserved.
//

import Foundation

protocol ApiGetAdapterProtocol {
    func getSimpleApi(url: String, completionHandler: @escaping(Data?, AdapterErro) -> Void)    
}
