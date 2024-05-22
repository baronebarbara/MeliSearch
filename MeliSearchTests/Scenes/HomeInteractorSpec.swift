import XCTest

@testable import MeliSearch

private final class HomePresenterSpy: HomePresenterProtocol {
    enum Method {
        case presentProductSearch,
             presentSelectedItem,
             presentLoading,
             presentEmptyState,
             presentError,
             presentInitialState
    }
    
    private var methodsCalled: [Method] = []
    private(set) var produtcSearch: ProductSearch?
    private(set) var selectedItem: ProductSearchDetail?
    private(set) var shouldPresentLoading: Bool?
    
    func present(productSearch: ProductSearch) {
        self.produtcSearch = productSearch
        methodsCalled.append(.presentProductSearch)
    }
    
    func present(selectedItem: ProductSearchDetail) {
        self.selectedItem = selectedItem
        methodsCalled.append(.presentSelectedItem)
    }
    
    func presentLoading(shouldPresent: Bool) {
        self.shouldPresentLoading = shouldPresent
        methodsCalled.append(.presentLoading)
    }
    
    func presentEmptyState() {
        methodsCalled.append(.presentEmptyState)
    }
    
    func presentError() {
        methodsCalled.append(.presentError)
    }
    
    func presentInitialState() {
        methodsCalled.append(.presentInitialState)
    }
}

final class HomeInteractorSpec: XCTestCase {
    
}
