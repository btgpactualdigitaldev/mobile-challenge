import Foundation

class ConversionManager {
    private let quotesRequest = QuotesRequest()
    private var quotes: [Quote] = []
    
    func getQuotes() {
        quotesRequest.getQuotes { (quotes) in
            self.quotes = quotes.convertQuotes()
        } onError: { (error) in
            switch error {
            case .invalidJSON:
                print("Invalid JSON")
            case .noData:
                print("no Data")
            case .noResponse:
                print("No Response")
            case .responseStatusCode(cod: 404):
                print("Not Found")
            case .taskError(let error):
                print(error)
            case .url:
                print("Problem with url")
            default:
                print("Another type of error")
            }
        }
    }
    
    func makeAConversion(initialCurrency: String, finalCurrency: String, value: Double) -> Double {
        var initialCurrencyExchangeRate = 0.0
        var finalCurrencyExchangeRate = 0.0
        for quote in quotes {
            if quote.name.contains("USD" + initialCurrency) {
                initialCurrencyExchangeRate = quote.value
            }
            if quote.name.contains("USD" + finalCurrency) {
                finalCurrencyExchangeRate = quote.value
            }
        }
        let conversionInDollar = value / initialCurrencyExchangeRate
        let finalConversion = conversionInDollar * finalCurrencyExchangeRate
        return finalConversion
    }
}
