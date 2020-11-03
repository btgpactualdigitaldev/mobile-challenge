//
//  CurrencyError.swift
//  CurrencyServices
//
//  Created by Breno Aquino on 01/11/20.
//

import Foundation

class CurrencyErrorModel: Codable {
    var code: Int?
    var info: String?
    
    init(code: Int?, info: String?) {
        self.code = code
        self.info = info
    }
}

public class CurrencyError: Error {
    
    enum ErrorType: Int {
        case unknowError = 0
        case encodingError = 1
    }
    
    private var model: CurrencyErrorModel?
    public var code: Int { model?.code ?? ErrorType.unknowError.rawValue }
    public var info: String { model?.info ?? "Unknow Error" }
    
    init(error: Error? = nil, data: Data? = nil) {
        if let data = data {
            do {
                model = try JSONDecoder().decode(CurrencyErrorModel.self, from: data)
            } catch {
                model = CurrencyErrorModel(code: ErrorType.encodingError.rawValue, info: "Encoding Error")
            }
        } else if let error = error as NSError? {
            model = CurrencyErrorModel(code: error.code, info: error.localizedDescription)
        } else {
            model = CurrencyErrorModel(code: ErrorType.unknowError.rawValue, info: "Unknow Error")
        }
    }
    
    init(type: ErrorType, info: String) {
        model = CurrencyErrorModel(code: type.rawValue, info: info)
    }
}
