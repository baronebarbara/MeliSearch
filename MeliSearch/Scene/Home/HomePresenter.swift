import Foundation

protocol HomePresenterProtocol {
    func present(productSearch: ProductSearch)
    func present(selectedItem: ProductSearch)
    func presentLoading()
    func presentEmptyState()
    func presentError()
    func presentetInitialState()
}

final class HomePresenter: HomePresenterProtocol {
    weak var viewControllerr: HomeViewControlleProtocol?
    private let coordinator: HomeCoordinatorProtocol
    
    init(coordinator: HomeCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func present(productSearch: ProductSearch) {}
    
    func present(selectedItem: ProductSearch) {}
    
    func presentLoading() {}
    
    func presentEmptyState() {}
    
    func presentError() {}
    
    func presentetInitialState() {}
}
