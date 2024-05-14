import Foundation

protocol HomeInteractorProtocol {
    
}

final class HomeInteractor: HomeInteractorProtocol {
    private let presenter: HomePresenterProtocol
    private let service: ProductSearchServiceProtocol
    
    init(presenter: HomePresenterProtocol,
         service: ProductSearchServiceProtocol) {
        self.presenter = presenter
        self.service = service
    }
}
