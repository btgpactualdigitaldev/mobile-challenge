import Foundation
import Data
import Infra
import Domain

final class UseCaseFactory {
    private static let httpClient = AlamofireAdapter()
    private static let apiBaseUrl = Environment.variable(.apiBaseUrl)
    private static let apiKey = Environment.variable(.apiKey)
    
    private static func makeUrl(path: String) -> URL {
        return URL(string: "\(apiBaseUrl)/\(path)?access_key=\(apiKey)")!
    }
    static func makeRemoteListQuotes() -> ListQuotes {
        let remoteListQuotes = RemoteListQuotes(url: makeUrl(path: "live"), httpClient: httpClient)
        return MainQueueDipatchDecorator(remoteListQuotes)
    }
}
