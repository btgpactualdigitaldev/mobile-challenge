//
//  Validate.swift
//  CoinExchanger
//
//  Created by Edson Rottava on 09/06/21.
//

import UIKit

enum ValidateType: Int {
    case cardCvv
    case cardNumber
    case cardVal
    case cep
    case cnh
    case cnpj
    case cpf
    case cpfj
    case date
    case email
    case filled
    case name
    case none
    case number
    case password
    case phone
    case time
    case value
}

class Validate {
    static let cardCvv = "[0-9]{3}"
    static let cardNumber = "[0-9]{4} [0-9]{4} [0-9]{4} [0-9]{4}"
    static let cardVal = "[0-9]{2}/[0-9]{4}"
    static let cepPattern = "[0-9]{5}-[0-9]{3}"
    static let cnhPattern = "[0-9]{3}.[0-9]{3}.[0-9]{3}.[0-9]{3}"
    static let cnpjPattern = "[0-9]{2}.[0-9]{3}.[0-9]{3}\\/[0-9]{4}-[0-9]{2}"
    static let cpfPattern = "[0-9]{3}.[0-9]{3}.[0-9]{3}-[0-9]{2}"
    static let datePatern = "[0-9]{2}\\/[0-9]{2}\\/[0-9]{4}"
    static let emailPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    static let namePattern = "[A-Za-z]{2} [A-Za-z]{2}"
    static let numberPatter = "[0-9]{1,}"
    static let passwordPattern = "(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])[a-zA-Z0-9]{6,16}"
    static let phonePattern = "\\([0-9]{2}\\)[0-9]{4,5}-[0-9]{4}"
    static let timePattern = "[0-9]{2}\\:[0-9]{2}"
    static let valuePattern = "[0-9]{0,}\\,[0-9]{2}"
    
    class func text(_ text: String, type: ValidateType) -> Bool {
        var t = text
        var pattern = ""
        var extra = true
        
        switch type {
        case .cardCvv:
            pattern = cardCvv
        case .cardNumber:
            pattern = cardNumber
        case .cardVal:
            let e = Int(t.prefix(2)) ?? 0
            extra = e < 13 && e > 0
            pattern = cardVal
        case .cep:
            pattern = cepPattern
        case .cnh:
            pattern = cnhPattern
        case .cnpj:
            pattern = cnpjPattern
        case .cpf:
            pattern = cpfPattern
        case .cpfj:
            let t = Sanityze.number(text)
            pattern = t.count > 11 ? cnpjPattern : cpfPattern
        case .date:
            pattern = datePatern
        case .email:
            pattern = emailPattern
        case .filled:
            return !t.isEmpty
        case .name:
            t = Sanityze.normalize(text)
            pattern = namePattern
        case .none:
            return true
        case .number:
            pattern = numberPatter
        case .password:
            pattern = passwordPattern
        case .phone:
            pattern = phonePattern
        case .time:
            pattern = timePattern
        case .value:
            pattern = valuePattern
        }
        
        let range = NSRange(location: 0, length: t.count)
        guard let regex = try? NSRegularExpression(pattern: pattern,
                                                   options: NSRegularExpression.Options())
            else { return false }
        let valid = regex.firstMatch(in: t,
                                    options: NSRegularExpression.MatchingOptions(),
                                    range: range) != nil
        return valid && extra
    }
}

