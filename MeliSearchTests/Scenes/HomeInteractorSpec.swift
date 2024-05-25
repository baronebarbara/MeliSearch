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

    var methodsCalled: [Method] = []
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

private final class ProductSearchServiceStub: ProductSearchServiceProtocol {
    var isSuccess: Bool = true,
        isEmpty: Bool = false

    func fetchProducts(text: String, itemsPerPage: Int, page: Int, success: @escaping (MeliSearch.ProductSearch) -> Void, failure: @escaping () -> Void) {
        let json = isEmpty ? HomeMockResponse.emptyResponse : HomeMockResponse.json

        if isSuccess,
           let data = json.data(using: .utf8),
           let response = try? JSONDecoder().decode(ProductSearch.self, from: data) {
            success(response)
        } else {
            failure()
        }
    }
}

final class HomeInteractorSpec: XCTestCase {
    private let presenter = HomePresenterSpy()
    private let service = ProductSearchServiceStub()

    private lazy var sut = HomeInteractor(presenter: presenter, 
                                          service: service)

    func test_SearchProduct_ThenSuccess_ShouldCallCorrectlyMethods() {
        sut.search(product: "iPhone")

        XCTAssertEqual(presenter.methodsCalled, [.presentLoading,
                                                 .presentLoading,
                                                 .presentProductSearch])
    }

    func test_SearchProduct_ThenSuccessButIsEmpty_ShouldCallCorrectlyMethods() {
        service.isEmpty = true

        sut.search(product: "Samsung")

        XCTAssertEqual(presenter.methodsCalled, [.presentLoading,
                                                 .presentLoading,
                                                 .presentEmptyState])
    }

    func test_SearchProduct_ThenFailure_ShouldCallCorrectlyMethods() {
        service.isSuccess = false

        sut.search(product: "Motor")

        XCTAssertEqual(presenter.methodsCalled, [.presentLoading,
                                                 .presentLoading,
                                                 .presentError])
    }

    func test_LoadNextPage_ThenSuccess_ShouldCallCorrectlyMethods() {
        sut.loadNextPage()

        XCTAssertEqual(presenter.methodsCalled, [.presentLoading,
                                                 .presentProductSearch])
    }

    func test_DidSelect_WhenSelectedItem_ShouldShowCorrectlyItemAndInformations() {
        sut.didSelect(productItem: .init(id: "123",
                                         title: "Motorola 34",
                                         price: 1999.99,
                                         thumbnail: "http://mla-s1-p.mlstatic.com/943469-MLA31002769183_062019-I.jpg"))


        XCTAssertEqual(presenter.selectedItem, .init(id: "123",
                                                     title: "Motorola 34",
                                                     price: 1999.99,
                                                     thumbnail: "http://mla-s1-p.mlstatic.com/943469-MLA31002769183_062019-I.jpg"))
        XCTAssertEqual(presenter.methodsCalled, [.presentSelectedItem])
    }
}
