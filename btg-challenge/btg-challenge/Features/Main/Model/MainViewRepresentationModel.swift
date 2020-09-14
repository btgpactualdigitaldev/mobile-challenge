//
//  MainViewRepresentationModel.swift
//  btg-challenge
//
//  Created by Wesley Araujo on 13/09/20.
//  Copyright © 2020 Wesley Araujo. All rights reserved.
//

import Foundation

struct MainViewRepresentationModel {
    struct Request {
        var sourceCurrency: String?
        var convertedCurrency: String?
        var valueToConvertInCurrency: String?
    }
    
    struct Response {
        var resultValueFromConversionCurrency: String?
    }
}
