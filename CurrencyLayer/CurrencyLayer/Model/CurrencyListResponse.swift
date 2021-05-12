import Foundation

struct CurrencyListResponse: Decodable {
  var currencies: [String:String]
}
