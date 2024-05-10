import Foundation

struct ProductSearchRequest: Request {
    var method: HTTPMethod = .get
    var endpoint: String { "sites/\(siteID)/search" }
    var parameters: [URLQueryItem] { [URLQueryItem(name: "category", value: categoryID)] }
    
    private var siteID: String
    private var categoryID: String
    
    init(siteID: String, categoryID: String) {
        self.siteID = siteID
        self.categoryID = categoryID
    }
}
