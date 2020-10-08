import Foundation

public protocol HttpGetClient {
    func get(to url: URL, completion: @escaping (Result<Data?, HttpError>) -> Void)
}
