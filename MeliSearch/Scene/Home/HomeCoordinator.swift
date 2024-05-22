import SwiftUI
import UIKit

enum HomeCoordinatorAction {
    case showProductItem(productItem: ProductSearchDetail)
}

protocol HomeCoordinatorProtocol: AnyObject {
    func perform(action: HomeCoordinatorAction)
}

final class HomeCoordinator: HomeCoordinatorProtocol {
    var viewController: UIViewController?
    
    func perform(action: HomeCoordinatorAction) {
        switch action {
        case .showProductItem(productItem: let productItem):
            showProductDetail(productItem: productItem)
        }
    }
    
    private func showProductDetail(productItem: ProductSearchDetail) {
        let product = Product(id: Int(productItem.id) ?? 0,
                              name: productItem.title,
                              price: productItem.price,
                              imageUrl: URL(string: productItem.thumbnail))
        
        let productDetailView = ProductDetailsView(product: product)
        let hostingController = UIHostingController(rootView: productDetailView)
        
        if let navigationController = viewController as? UINavigationController {
            navigationController.pushViewController(hostingController, animated: true)
        } else {
            viewController?.present(hostingController, animated: true, completion: nil)
        }
    }
}
