import Foundation

protocol HomeInteractorProtocol {
    func search(product: String?)
    func loadNextPage()
    func initialState()
    func didSelect(productItem: ProductSearchDetail)
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
        presenter.presentLoading(shouldPresent: true)
        
        page = product != nil ? 0 : page
        searchProduct = product ?? searchProduct
        
        service.fetchProducts(text: searchProduct, itemsPerPage: itemsPerPage, page: page) { [weak self] result in
            self?.presenter.presentLoading(shouldPresent: false)
            
            switch result {
            case .success(let success) where success.results.isEmpty:
                self?.presenter.presentEmptyState()
            case .success(let success):
                self?.page += 1
                self?.presenter.present(productSearch: success)
            case .failure(_):
                self?.presenter.presentError()
            }
        }
    }
    
    func loadNextPage() {
        service.fetchProducts(text: searchProduct, itemsPerPage: itemsPerPage, page: page) { [weak self] result in
            
            switch result {
            case .success(let success) where success.results.isEmpty:
                self?.presenter.presentEmptyState()
            case .success(let success):
                self?.page += 1
                self?.presenter.present(productSearch: success)
            case .failure(_):
                self?.presenter.presentError()
            }
        }
    }
    
    func initialState() {
        presenter.presentInitialState()
    }
    
    func didSelect(productItem: ProductSearchDetail) {
        presenter.present(selectedItem: productItem)
    }
}
