import Foundation

protocol HomePresenterProtocol {
    func present(productSearch: ProductSearch)
    func present(selectedItem: ProductItem)
    func presentLoading(shouldPresent: Bool)
    func presentEmptyState()
    func presentError()
    func presentInitialState()
    func presentLoadingCell(shouldPresent: Bool)
}

final class HomePresenter: HomePresenterProtocol {
    weak var viewControllerr: HomeViewControllerProtocol?
    private let coordinator: HomeCoordinatorProtocol
    
    init(coordinator: HomeCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func present(productSearch: ProductSearch) {
        viewControllerr?.showInitialState(shouldShow: false)
        viewControllerr?.hideEmpty()
        viewControllerr?.hideError()
        viewControllerr?.show(search: productSearch)
        viewControllerr?.showProductSearch(shouldShow: true)
    }
    
    func present(selectedItem: ProductItem) {
        coordinator.perform(action: .showProductItem(productItem: selectedItem))
    }
    
    func presentLoading(shouldPresent: Bool) {
        viewControllerr?.showProductSearch(shouldShow: false)
        viewControllerr?.showInitialState(shouldShow: false)
        viewControllerr?.hideEmpty()
        viewControllerr?.hideError()
        shouldPresent ? viewControllerr?.startLoading() : viewControllerr?.stopLoading()
    }
    
    func presentEmptyState() {
        viewControllerr?.showProductSearch(shouldShow: false)
        viewControllerr?.showInitialState(shouldShow: false)
        viewControllerr?.hideEmpty()
        viewControllerr?.hideError()
        viewControllerr?.showEmpty()
    }
    
    func presentError() {
        viewControllerr?.showProductSearch(shouldShow: false)
        viewControllerr?.showInitialState(shouldShow: false)
        viewControllerr?.hideEmpty()
        viewControllerr?.hideError()
        viewControllerr?.showError()
    }
    
    func presentInitialState() {
        viewControllerr?.showProductSearch(shouldShow: false)
        viewControllerr?.hideEmpty()
        viewControllerr?.hideError()
        viewControllerr?.showInitialState(shouldShow: true)
    }
    
    func presentLoadingCell(shouldPresent: Bool) {
        shouldPresent ? viewControllerr?.startLoadingCell() : viewControllerr?.stopLoadingCell()
    }
}
