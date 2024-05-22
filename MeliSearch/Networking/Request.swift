import Foundation

protocol Request {
    var method: HTTPMethod { get }
    var endpoint: String { get }
    var parameters: [URLQueryItem] { get }
}

enum HTTPMethod: String {
    case get = "GET",
        post = "POST"
}
