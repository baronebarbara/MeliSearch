import XCTest

@testable import MeliSearch

private final class HomeViewControllerSpy: HomeViewControllerProtocol {
    enum Method {
        case startLoading,
             stopLoading,
             showSearch,
             showProductSearch,
             showEmpty,
             showError,
             hideEmpty,
             hideError,
             showInitialState
    }

    var methodsCalled: [Method] = []
    private(set) var search: ProductSearch?
    private(set) var shouldShowProductSearch: Bool?
    private(set) var shouldShowInitialState: Bool?

    func startLoading() {
        methodsCalled.append(.startLoading)
    }

    func stopLoading() {
        methodsCalled.append(.stopLoading)
    }

    func show(search: ProductSearch) {
        self.search = search
        methodsCalled.append(.showSearch)
    }

    func showProductSearch(shouldShow: Bool) {
        self.shouldShowProductSearch = shouldShow
        methodsCalled.append(.showProductSearch)
    }

    func showEmpty() {
        methodsCalled.append(.showEmpty)
    }

    func showError() {
        methodsCalled.append(.showError)
    }

    func hideEmpty() {
        methodsCalled.append(.hideEmpty)
    }

    func hideError() {
        methodsCalled.append(.hideError)
    }

    func showInitialState(shouldShow: Bool) {
        self.shouldShowInitialState = shouldShow
        methodsCalled.append(.showInitialState)
    }
}

private final class HomeCoordinatorSpy: HomeCoordinatorProtocol {
    enum Method {
        case perform
    }

    var methodsCalled: [Method] = []
    private(set) var action: HomeCoordinatorAction?

    func perform(action: HomeCoordinatorAction) {
        self.action = action
        methodsCalled.append(.perform)
    }
}

enum HomePresenterFactory {
    static func buildPresenter(view: HomeViewControllerProtocol,
                               coordinator: HomeCoordinatorProtocol) -> HomePresenterProtocol {
        let presenter = HomePresenter(coordinator: coordinator)
        presenter.viewController = view
        return presenter
    }
}

final class HomePresenterSpec: XCTestCase {
    private let coordinatorSpy = HomeCoordinatorSpy()
    private let viewControllerSpy = HomeViewControllerSpy()

    private lazy var sut = HomePresenterFactory.buildPresenter(view: viewControllerSpy,
                                                               coordinator: coordinatorSpy)

    func test_PresentProductSearch_ThenHasProductSearch_ShouldShowCorrectlyMethods() {
        let json = HomeMockResponse.json
        let data = json.data(using: .utf8)
        guard let product = (try? JSONDecoder().decode(ProductSearch.self, from: data ?? Data())) else { return }

        sut.present(productSearch: product)

        XCTAssertEqual(viewControllerSpy.methodsCalled, [.showInitialState,
                                                         .hideEmpty,
                                                         .hideError,
                                                         .showSearch,
                                                         .showProductSearch])
        XCTAssertEqual(viewControllerSpy.search, product)
        XCTAssertEqual(viewControllerSpy.shouldShowProductSearch, true)
        XCTAssertEqual(viewControllerSpy.shouldShowInitialState, false)
    }

    func test_PresentSelectedItem_ShouldShowCorrectlyMethods() {
        let productDetail = ProductSearchDetail(id: "123",
                                                title: "Motorola 34",
                                                price: 1999.99,
                                                thumbnail: "http://mla-s1-p.mlstatic.com/943469-MLA31002769183_062019-I.jpg")

        sut.present(selectedItem: productDetail)

        XCTAssertEqual(coordinatorSpy.methodsCalled, [.perform])
        XCTAssertEqual(coordinatorSpy.action, .showProductItem(productItem: productDetail))
    }

    func test_presentLoading_WhenShowLoading_ShouldCallCorrectlyMethods() {
        sut.presentLoading(shouldPresent: true)

        XCTAssertEqual(viewControllerSpy.methodsCalled, [.showProductSearch,
                                                         .showInitialState,
                                                         .hideEmpty,
                                                         .hideError,
                                                         .startLoading])
        XCTAssertEqual(viewControllerSpy.shouldShowProductSearch, false)
        XCTAssertEqual(viewControllerSpy.shouldShowInitialState, false)
    }

    func test_presentLoading_WhenStopLoading_ShouldCallCorrectlyMethods() {
        sut.presentLoading(shouldPresent: false)

        XCTAssertEqual(viewControllerSpy.methodsCalled, [.showProductSearch,
                                                         .showInitialState,
                                                         .hideEmpty,
                                                         .hideError,
                                                         .stopLoading])
        XCTAssertEqual(viewControllerSpy.shouldShowProductSearch, false)
        XCTAssertEqual(viewControllerSpy.shouldShowInitialState, false)
    }

    func test_presentEmptyState_ShouldCallCorrectlyMethods() {
        sut.presentEmptyState()

        XCTAssertEqual(viewControllerSpy.methodsCalled, [.showProductSearch,
                                                         .showInitialState,
                                                         .hideEmpty,
                                                         .hideError,
                                                         .showEmpty])
        XCTAssertEqual(viewControllerSpy.shouldShowProductSearch, false)
        XCTAssertEqual(viewControllerSpy.shouldShowInitialState, false)
    }

    func test_presentError_ShouldCallCorrectlyMethods() {
        sut.presentError()

        XCTAssertEqual(viewControllerSpy.methodsCalled, [.showProductSearch,
                                                         .showInitialState,
                                                         .hideEmpty,
                                                         .showError])
        XCTAssertEqual(viewControllerSpy.shouldShowProductSearch, false)
        XCTAssertEqual(viewControllerSpy.shouldShowInitialState, false)
    }

    func test_presentInitialState_ShouldCallCorrectlyMethods() {
        sut.presentInitialState()

        XCTAssertEqual(viewControllerSpy.methodsCalled, [.showProductSearch,
                                                         .hideEmpty,
                                                         .hideError,
                                                         .showInitialState])
        XCTAssertEqual(viewControllerSpy.shouldShowProductSearch, false)
        XCTAssertEqual(viewControllerSpy.shouldShowInitialState, true)
    }
}
