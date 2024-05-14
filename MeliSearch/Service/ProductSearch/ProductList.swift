import Foundation

struct ProductList: Decodable {
    let totalResults: Int
    let results: [ProductListDetail]
    
    private enum CodingKeys: String, CodingKey {
        case paging,
             total,
             results
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let paging = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .paging)
        totalResults = try paging.decode(Int.self, forKey: .total)
        results = try container.decode([ProductListDetail].self, forKey: .results)
    }
    
    struct ProductListDetail: Decodable {
        let id: String
        let title: String
        let price: Double
        let thumbnail: String
    }
}
