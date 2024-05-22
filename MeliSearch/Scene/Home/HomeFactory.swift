import UIKit

enum HomeFactory {
    static func make() -> HomeViewController {
        let coordinator = HomeCoordinator()
        let presenter = HomePresenter(coordinator: coordinator)
        let interactor: HomeInteractorProtocol = HomeInteractor(presenter: presenter, service: ProductSearchService())
        let viewController = HomeViewController(interactor: interactor)
        
        presenter.viewController = viewController
        coordinator.viewController = viewController
        
        return viewController
    }
}
