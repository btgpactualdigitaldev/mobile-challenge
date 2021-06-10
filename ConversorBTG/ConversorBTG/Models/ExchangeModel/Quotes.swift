import Foundation

struct Quotes: Decodable {
    var success: Bool
    var quotes: [String: Double]
    
    func convertQuotes() -> [Quote]{
        var result: [Quote] = []
        for (key, value) in quotes {
            result.append(Quote(name: key, value: value))
        }
        return result
    }
}

struct Quote: Decodable {
    var name: String
    var value: Double
}
