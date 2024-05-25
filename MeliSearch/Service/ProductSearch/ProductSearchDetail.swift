import Foundation

struct ProductSearchDetail: Decodable, Equatable {
    let id: String
    let title: String
    let price: Double
    let thumbnail: String
}
