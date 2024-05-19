import Foundation

struct API {
    static let baseURL = "https://api.mercadolibre.com/"
}

final class ApiURLConfig {
    static var host: String? {
        return get("API_HOST")
    }
    
    static var site: String? {
        return get("SITE_ID")
    }
    
    static func get<T>(_ name: String, bundle: Bundle = Bundle.main) -> T? {
        guard let enviromentSettings = bundle.infoDictionary?["EnviromentSettings"] as? [String: AnyObject],
            let key = enviromentSettings[name] else {
            return nil
        }
        
        return key as? T
    }
}
