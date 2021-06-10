import Foundation

struct Currencies: Decodable {
    var success: Bool
    var currencies: [String: String]
    
    func convertCurrencies() -> [Currency]{
        var result: [Currency] = []
        for (key, value) in currencies {
            result.append(Currency(name: key, description: value))
        }
        return result
    }
}

struct Currency: Decodable {
    var name: String
    var description: String
}
