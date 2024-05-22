import UIKit

enum HomeCoordinatorAction {
    case showProductItem(productItem: ProductSearchDetail)
}

protocol HomeCoordinatorProtocol: AnyObject {
    var viewController: UIViewController? { get set }
    func perform(action: HomeCoordinatorAction)
}

final class HomeCoordinator: HomeCoordinatorProtocol {
    var viewController: UIViewController?
    
    func perform(action: HomeCoordinatorAction) {}
}
