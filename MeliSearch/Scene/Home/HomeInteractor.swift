import Foundation

protocol HomeInteractorProtocol {
    func search(product: String?)
}

final class HomeInteractor: HomeInteractorProtocol {
    private let presenter: HomePresenterProtocol
    private let service: ProductSearchServiceProtocol
    private let itemsPerPage = 10
    private var page = 0
    private var searchProduct = ""
    
    init(presenter: HomePresenterProtocol,
         service: ProductSearchServiceProtocol) {
        self.presenter = presenter
        self.service = service
    }
    
    func search(product: String?) {
        presenter.presentLoading()
        
        page = product != nil ? 0 : page
        searchProduct = product ?? searchProduct
        
        service.fetchProducts(text: searchProduct, itemsPerPage: itemsPerPage, page: page) { [weak self] result in
            self?.presenter.stopLoading()
            
            switch result {
            case .success(let success) where success.results.isEmpty:
                self?.presenter.presentEmptyState()
            case .success(let success):
                self?.page += 1
                self?.presenter.present(productSearch: success)
            case .failure(let failure):
                self?.presenter.presentError()
            }
        }
    }
}
