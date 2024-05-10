import Foundation

protocol ProductSearchServiceProtocol {
    
}

final class ProductSearchService: ProductSearchServiceProtocol {
    private let network: NetworkProtocol
    
    init(network: NetworkProtocol = Network()) {
        self.network = network
    }
    
    func fetchProducts(siteID: String, categoryID: String) {
        let request = ProductSearchRequest(siteID: siteID, categoryID: categoryID)
        
        network.execute(with: request) { (result: Result<ProductTe, Error>) in
            switch result {
            case .success(let response):
                print(response)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

struct ProductTe: Decodable {
    let site_id: String
}
