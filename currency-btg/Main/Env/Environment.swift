import Foundation

public final class Environment {
    public enum EnvironmentVariables: String {
        case apiBaseUrl = "API_BASE_URL"
        case apiKey = "API_KEY"
    }
    
    public static func variable(_ key: EnvironmentVariables) -> String {
        return Bundle.main.infoDictionary![key.rawValue] as! String
    }
}
