
import Foundation

extension JSONDecoder {
    
    static var decoder: JSONDecoder {
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .millisecondsSince1970
        return decoder
    }
}
