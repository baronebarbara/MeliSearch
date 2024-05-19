import Foundation

protocol ProductSearchServiceProtocol {
    func fetchProducts(text: String,
                       itemsPerPage: Int,
                       page: Int,
                       completion: @escaping ((Result<ProductSearch, Error>) -> Void))
}

final class ProductSearchService: ProductSearchServiceProtocol {
    private let network: NetworkProtocol
    
    init(network: NetworkProtocol = Network()) {
        self.network = network
    }
    
    func fetchProducts(text: String,
                       itemsPerPage: Int,
                       page: Int,
                       completion: @escaping ((Result<ProductSearch, Error>) -> Void)) {
        let request = ProductSearchRequest(text: text, itemsPerPage: itemsPerPage, page: page)
        
        network.execute(with: request) { (result: Result<ProductSearch, Error>) in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
