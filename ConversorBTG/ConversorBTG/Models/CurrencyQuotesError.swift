import Foundation

enum CurrencyQuotesError {
    case url
    case taskError(error: Error)
    case noResponse
    case noData
    case responseStatusCode(cod: Int)
    case invalidJSON
}
