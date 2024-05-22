import Foundation

struct ProductSearch: Decodable {
    let totalResults: Int
    let results: [ProductSearchDetail]
    
    private enum CodingKeys: String, CodingKey {
        case paging,
             total,
             results
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let paging = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .paging)
        totalResults = try paging.decode(Int.self, forKey: .total)
        results = try container.decode([ProductSearchDetail].self, forKey: .results)
    }
}
