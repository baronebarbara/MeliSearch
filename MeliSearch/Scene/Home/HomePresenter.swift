import Foundation

protocol HomePresenterProtocol {
    func present(productSearch: ProductSearch)
    func present(selectedItem: ProductSearchDetail)
    func presentLoading(shouldPresent: Bool)
    func presentEmptyState()
    func presentError()
    func presentInitialState()
    func presentLoadingCell(shouldPresent: Bool)
}

final class HomePresenter: HomePresenterProtocol {
    weak var viewController: HomeViewControllerProtocol?
    private let coordinator: HomeCoordinatorProtocol
    
    init(coordinator: HomeCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func present(productSearch: ProductSearch) {
        viewController?.showInitialState(shouldShow: false)
        viewController?.hideEmpty()
        viewController?.hideError()
        viewController?.show(search: productSearch)
        viewController?.showProductSearch(shouldShow: true)
    }
    
    func present(selectedItem: ProductSearchDetail) {
        coordinator.perform(action: .showProductItem(productItem: selectedItem))
    }
    
    func presentLoading(shouldPresent: Bool) {
        viewController?.showProductSearch(shouldShow: false)
        viewController?.showInitialState(shouldShow: false)
        viewController?.hideEmpty()
        viewController?.hideError()
        shouldPresent ? viewController?.startLoading() : viewController?.stopLoading()
    }
    
    func presentEmptyState() {
        viewController?.showProductSearch(shouldShow: false)
        viewController?.showInitialState(shouldShow: false)
        viewController?.hideEmpty()
        viewController?.hideError()
        viewController?.showEmpty()
    }
    
    func presentError() {
        viewController?.showProductSearch(shouldShow: false)
        viewController?.showInitialState(shouldShow: false)
        viewController?.hideEmpty()
        viewController?.hideError()
        viewController?.showError()
    }
    
    func presentInitialState() {
        viewController?.showProductSearch(shouldShow: false)
        viewController?.hideEmpty()
        viewController?.hideError()
        viewController?.showInitialState(shouldShow: true)
    }
    
    func presentLoadingCell(shouldPresent: Bool) {
        shouldPresent ? viewController?.startLoadingCell() : viewController?.stopLoadingCell()
    }
}
