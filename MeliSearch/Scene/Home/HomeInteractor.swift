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
        
        fetchProducts()
    }
    
    func loadNextPage() {
        fetchProducts()
    }
    
    func initialState() {
        presenter.presentInitialState()
    }
    
    func didSelect(productItem: ProductSearchDetail) {
        presenter.present(selectedItem: productItem)
    }

    private func fetchProducts() {
        service.fetchProducts(text: searchProduct, itemsPerPage: itemsPerPage, page: page) { [weak self] response in
            self?.presenter.presentLoading(shouldPresent: false)
            if response.results.isEmpty {
                self?.presenter.presentEmptyState()
            } else {
                self?.page += 1
                self?.presenter.present(productSearch: response)
            }
        } failure: { [presenter] in
            presenter.presentLoading(shouldPresent: false)
            presenter.presentError()
        }
    }
}
