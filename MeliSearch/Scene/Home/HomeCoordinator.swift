import UIKit

enum HomeCoordinatorAction {
    case showProductItem(productItem: ProductItem)
}

protocol HomeCoordinatorProtocol: AnyObject {
    var viewController: UIViewController? { get set }
    func perform(action: HomeCoordinatorAction)
}
