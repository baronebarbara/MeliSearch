import UIKit

enum HomeFactory {
    static func make() -> HomeViewController {
        let coordinator: HomeCoordinatorProtocol = HomeCoordinator()
        let presenter = HomePresenter(coordinator: coordinator)
        let interactor: HomeInteractorProtocol = HomeInteractor(presenter: presenter, service: ProductSearchService())
        let viewController = HomeViewControllerProtocol = HomeViewController(interactor: interactor)
        
        presenter.viewController = viewController
    }
}
