import Foundation

struct ProductItem: Decodable {
    let id: String
    let title: String
    let price: Double
    let thumbnail: String
}
