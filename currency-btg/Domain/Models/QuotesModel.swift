import Foundation

public struct QuotesModel: Model {
    
    public typealias QuotesKey = String
    
    public var timestamp: Date
    public var source: String
    public var quotes: [QuotesKey: Double]
    
    public init(timestamp: Date, source: String, quotes: [QuotesKey: Double]) {
        self.timestamp = timestamp
        self.source = source
        self.quotes = quotes
    }
    
    enum CodingKeys:String, CodingKey {
      case timestamp
      case source
      case quotes
    }
    
    public init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: CodingKeys.self)
      let timestampUnix = try container.decode(TimeInterval.self, forKey: .timestamp)
      quotes = try container.decode([QuotesKey:Double].self, forKey: .quotes)
      source = try container.decode(String.self, forKey: .source)
      timestamp = Date(timeIntervalSince1970: timestampUnix)
    }
}
