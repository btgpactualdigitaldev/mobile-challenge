import Foundation

enum CurrencyLayerError: Error {
  case parsing(description: String)
  case network(description: String)
}
