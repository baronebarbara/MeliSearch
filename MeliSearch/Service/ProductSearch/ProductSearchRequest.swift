import Foundation

struct ProductSearchRequest: Request {
    var method: HTTPMethod = .get
    var endpoint: String {
        guard let site = ApiURLConfig.site else { return "" }
        
        return "sites/\(site)/search"
    }
    var parameters: [URLQueryItem] { [URLQueryItem(name: "q", value: text),
                                      URLQueryItem(name: "limit", value: String(itemsPerPage)),
                                      URLQueryItem(name: "offset", value: String(page))] }
    
    private var text: String
    private var itemsPerPage: Int
    private var page: Int
    
    init(text: String,
         itemsPerPage: Int,
         page: Int) {
        self.text = text
        self.itemsPerPage = itemsPerPage
        self.page = page
    }
}
