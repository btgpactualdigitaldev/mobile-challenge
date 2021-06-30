
import Foundation
import Moya

final class Service<Target: TargetType>  {
    
    private var provider: MoyaProvider<Target>
    
    init() {
        
        var plugins: [PluginType] = []
        plugins.append(NetworkLoggerPlugin())
        plugins.append(AccessTokenPlugin {_ in API.apiKey})
        
        self.provider = MoyaProvider<Target>(plugins: plugins)
    }
    
    func request<T: Decodable>(_ target: Target, completion: @escaping (Result<T, Error>) -> Void) {
        
        provider.request(target) { (result) in
            
            switch result {
            
            case .success(var response):
                
                do {
                    
                    response = try response.filterSuccessfulStatusCodes()
                    completion(response.decode(T.self))
                    
                } catch MoyaError.statusCode(let errorResponse) {
                    
                    guard let decodedError =
                        try? errorResponse.map(ApiError.self, using: JSONDecoder.decoder) else {
                        
                        completion(.failure(ApiError(status: 0, message: "")))
                        return
                    }
                    
                    completion(.failure(decodedError))
                    
                } catch {
                    
                    completion(.failure(ApiError(status: 0, message: "")))
                    
                }
                
            case .failure(let error):
                
                completion(.failure(error))
                
            }
        }
    }
    
    func requestWithEmptyResponse(_ target: Target, completion: @escaping (Result<Void, Error>) -> Void) {
       
        provider.request(target) { (result) in
            
            switch result {
                
            case .success(let response):
                
                do {
                    
                    _ = try response.filterSuccessfulStatusCodes()
                    completion(.success(()))
                    
                } catch MoyaError.statusCode(let errorResponse) {
                    
                    guard let decodedError = try? errorResponse.map(ApiError.self, using: JSONDecoder.decoder) else {
                        
                        completion(.failure(ApiError(status: 0, message: "")))
                        return
                    }
                    
                    completion(.failure(decodedError))
                    
                } catch {
                    
                    completion(.failure(ApiError(status: 0, message: "")))
                    
                }
                
            case .failure(let error):
                
                completion(.failure(error))
                
            }
        }
    }
}
