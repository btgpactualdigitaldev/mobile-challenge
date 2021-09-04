//
//  Sanityzer.swift
//  CoinExchanger
//
//  Created by Edson Rottava on 09/06/21.
//

import UIKit

class Sanityze {
    class func number(_ text: String) -> String {
        var clean = ""
        
        for c in text {
            if (c.isNumber) {
                clean.append(c)
            }
        }
        
        return clean
    }
    
    class func char(_ text: String) -> String {
        var clean = ""
        
        for c in text {
            if (c.isLetter) {
                clean.append(c)
            }
        }
        
        return clean
    }
    
    class func charNumber(_ text: String) -> String {
        var clean = ""
        
        for c in text {
            if (c.isNumber || c.isLetter) {
                clean.append(c)
            }
        }
        
        return clean
    }
    
    class func alphaNumeric(_ text: String) -> String {
        var clean = ""
        
        for c in text {
            if (c.isNumber || c.isLetter || c.isSymbol) {
                clean.append(c)
            }
        }
        
        return clean
    }
    
    class func currency(_ text: String) -> String {
        var clean = ""
        
        for c in text {
            if (c.isNumber || c == ".") {
                clean.append(c)
            }
        }
        
        return clean
    }
    
    class func normalize(_ text: String?) -> String {
        guard let t = text else { return "" }
        var norma = t.lowercased()
        norma = norma.replacingOccurrences(of: "ã", with: "a")
        norma = norma.replacingOccurrences(of: "â", with: "a")
        norma = norma.replacingOccurrences(of: "á", with: "a")
        norma = norma.replacingOccurrences(of: "à", with: "a")
        norma = norma.replacingOccurrences(of: "ä", with: "a")
        
        norma = norma.replacingOccurrences(of: "ê", with: "e")
        norma = norma.replacingOccurrences(of: "é", with: "e")
        norma = norma.replacingOccurrences(of: "è", with: "e")
        norma = norma.replacingOccurrences(of: "ë", with: "e")
        
        norma = norma.replacingOccurrences(of: "î", with: "i")
        norma = norma.replacingOccurrences(of: "í", with: "i")
        norma = norma.replacingOccurrences(of: "ì", with: "i")
        norma = norma.replacingOccurrences(of: "ï", with: "i")

        norma = norma.replacingOccurrences(of: "ô", with: "o")
        norma = norma.replacingOccurrences(of: "õ", with: "o")
        norma = norma.replacingOccurrences(of: "ó", with: "o")
        norma = norma.replacingOccurrences(of: "ò", with: "o")
        norma = norma.replacingOccurrences(of: "ö", with: "o")
        
        norma = norma.replacingOccurrences(of: "û", with: "u")
        norma = norma.replacingOccurrences(of: "u", with: "u")
        norma = norma.replacingOccurrences(of: "ú", with: "u")
        norma = norma.replacingOccurrences(of: "ù", with: "u")
        norma = norma.replacingOccurrences(of: "ü", with: "u")
        
        norma = norma.replacingOccurrences(of: "ç", with: "c")
        norma = norma.replacingOccurrences(of: "ñ", with: "n")
        
        return norma
    }
}
