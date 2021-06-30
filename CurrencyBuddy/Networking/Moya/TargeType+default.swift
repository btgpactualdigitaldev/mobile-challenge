
import Foundation
import Moya

extension TargetType {

    var baseURL: URL {
        URL(string: API.currentScheme.url)!
    }

    var sampleData: Data { Data() }

    var headers: [String : String]? {
        ["Content-type":"application/json"]
    }
    
    func makeParamsDictionary(_ params: [String: Any?]) -> [String: Any] {
        
        var adjustedParams: [String: Any] = [:]
        
        for key in Array(params.keys) {
            if let content = params[key] {
                adjustedParams[key] = content
            }
        }
        
        return adjustedParams
    }
}
