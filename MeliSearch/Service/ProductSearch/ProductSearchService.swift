import Foundation

protocol ProductSearchServiceProtocol {
    func fetchProducts(siteID: String, categoryID: String, completion: @escaping ((Result<ProductList, Error>) -> Void))
}

final class ProductSearchService: ProductSearchServiceProtocol {
    private let network: NetworkProtocol
    
    init(network: NetworkProtocol = Network()) {
        self.network = network
    }
    
    func fetchProducts(siteID: String, categoryID: String, completion: @escaping ((Result<ProductList, Error>) -> Void)) {
        let request = ProductSearchRequest(siteID: siteID, categoryID: categoryID)
        
        network.execute(with: request) { (result: Result<ProductList, Error>) in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
