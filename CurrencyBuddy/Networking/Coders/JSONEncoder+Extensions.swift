
import Foundation

extension JSONEncoder {
    
    static var encoder: JSONEncoder {
        
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .millisecondsSince1970
        return encoder
    }
}
