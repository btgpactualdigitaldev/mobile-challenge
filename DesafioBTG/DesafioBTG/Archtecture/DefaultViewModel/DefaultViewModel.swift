//
//  DefaultViewModel.swift
//  DesafioBTG
//
//  Created by Bittencourt Mantavani, Rômulo on 02/09/20.
//  Copyright © 2020 Bittencourt Mantovani, Rômulo. All rights reserved.
//

import Foundation

class DefaultViewModel<T> {
    private var businessModel: T!
    
    init(withBusiness business: T) {
        self.businessModel = business
    }
    
    func getBusinessModel() -> T{
        return self.businessModel
    }
    
    func businessWithProtocol<T>(_ protocolType: T.Type) -> T {
        guard let swappedBusiness = self.businessModel as? T else {preconditionFailure("Passed a Protocol that the business does not inherit")}
        return swappedBusiness
    }
}
