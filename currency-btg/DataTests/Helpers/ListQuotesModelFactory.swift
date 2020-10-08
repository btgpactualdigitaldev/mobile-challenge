import Foundation
import Domain

func makeQuotesModel() -> QuotesModel {
    return QuotesModel(timestamp: Date(), source: "USD", quotes: ["USD": 1.0])
}
