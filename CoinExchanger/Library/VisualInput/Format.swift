//
//  Formator.swift
//  CoinExchanger
//
//  Created by Edson Rottava on 09/06/21.
//

import UIKit

class Format {
    
    /// 000
    class func cardCVV(_ text: String) -> String {
        var i = 0
        var f = ""
        let t = Sanityze.number(text)
        
        for c in t {
            i += 1
            if (i < 4) { f.append(c) }
        }
        
        return f
    }
    
    /// 0000 0000 0000 0000
    class func cardNumber(_ text: String) -> String {
        var i = 0
        var f = ""
        let t = Sanityze.number(text)
        
        for c in t {
            i += 1
            
            switch i {
            case 5, 9, 13:
                f.append(" ")
            default:
                break
            }
            
            if (i < 17) { f.append(c) }
        }
        
        return f
    }
    
    /// 00/0000
    class func cardVal(_ text: String) -> String {
        var i = 0
        var f = ""
        let t = Sanityze.number(text)
        
        for c in t {
            i += 1
            
            switch i {
            case 3:
                f.append("/")
            default:
                break
            }
            
            if (i < 7) { f.append(c) }
        }
        
        return f
    }
    
    /// 00000-000
    class func cep(_ text: String) -> String {
        var i = 0
        var f = ""
        let t = Sanityze.number(text)
        
        for c in t {
            i += 1
            
            switch i {
            case 6:
                f.append("-")
            default:
                break
            }
            
            if (i < 9) { f.append(c) }
        }
        
        return f
    }
    
    /// 000.000.000.000
    class func cnh(_ text: String) -> String {
        var i = 0
        var f = ""
        let t = Sanityze.number(text)
        
        for c in t {
            i += 1
            
            switch i {
            case 4, 7, 10:
                f.append(".")
            default:
                break
            }
            
            if (i < 13) { f.append(c) }
        }
        
        return f
    }
    
    /// 00.000.000/0000-00
    class func cnpj(_ text: String) -> String {
        var i = 0
        var f = ""
        let t = Sanityze.number(text)
        
        for c in t {
            i += 1
            
            switch i {
            case 3, 6:
                f.append(".")
            case 9:
                f.append("/")
            case 13:
                f.append("-")
            default:
                break
            }
            
            if (i < 15) { f.append(c) }
        }
        
        return f
    }
    
    /// 000.000.000-00
    class func cpf(_ text: String) -> String {
        var i = 0
        var f = ""
        let t = Sanityze.number(text)
        
        for c in t {
            i += 1
            
            switch i {
            case 4, 7:
                f.append(".")
            case 10:
                f.append("-")
            default:
                break
            }
            
            if (i < 12) { f.append(c) }
        }
        
        return f
    }
    
    /// 00/00/0000
    class func date(_ text: String) -> String {
        var i = 0
        var f = ""
        let t = Sanityze.number(text)
        
        for c in t {
            i += 1
            
            switch i {
            case 3, 5:
                f.append("/")
            default:
                break
            }
            
            if (i < 9) { f.append(c) }
        }
        
        return f
    }
    
    /// (00)00000-0000
    class func phone(_ text: String) -> String {
        var i = 0
        var f = ""
        let t = Sanityze.number(text)
        
        let k = t.count > 10 ? 1 : 0
        
        for c in t {
            i += 1
            
            switch i {
            case 1:
                f.append("(")
            case 3:
                f.append(")")
            case 7+k:
                f.append("-")
            default:
                break
            }
            
            if (i < 12) { f.append(c) }
        }
        
        return f
    }
    
    /// RS
    class func state(_ text: String) -> String {
        let t = Sanityze.normalize(text)
        
        switch t {
        case "acre":
            return "AC"
        case "alagoas":
            return "AL"
        case "amapa":
            return "AP"
        case "amazonas":
            return "AM"
        case "bahia":
            return "BA"
        case "ceara":
            return "CE"
        case "espirito santo":
            return "ES"
        case "goias":
            return "GO"
        case "maranhao":
            return "MA"
        case "mato grosso":
            return "MT"
        case "mato grosso do sul":
            return "MS"
        case "minas gerais":
            return "MG"
        case "para":
            return "PA"
        case "paraiba":
            return "PB"
        case "parana":
            return "PR"
        case "pernambuco":
            return "PE"
        case "piaui":
            return "PI"
        case "rio de janeiro":
            return "RJ"
        case "rio grande do norte":
            return "RN"
        case "rio grande do sul":
            return "RS"
        case "rondonia":
            return "RO"
        case "roraima":
            return "RR"
        case "santa catarina":
            return "SC"
        case "sao paulo":
            return "SP"
        case "sergipe":
            return "SE"
        case "tocantins":
            return "TO"
        case "distrito federal":
            return "DF"
        default:
            return t
        }
    }
    
    /// 00:00
    class func time(_ text: String) -> String {
        var i = 0
        var f = ""
        let t = Sanityze.number(text)
        
        for c in t {
            i += 1
            
            switch i {
            case 3:
                f.append(":")
            default:
                break
            }
            
            if (i < 5) { f.append(c) }
        }
        
        return f
    }
    
    /// 00000000,00
    class func value(_ text: String) -> String {
        var i = 0
        var f = ""
        let t = Sanityze.number(text)
        
        for c in t {
            i += 1
            
            switch i {
            case 3:
                f.append(",")
            default:
                break
            }
            
            if (i < 10) { f.append(c) }
        }
        
        return f
    }
}
