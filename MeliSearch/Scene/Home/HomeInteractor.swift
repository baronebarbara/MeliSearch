import Foundation

/// Protocolo que define as operações disponiveis no interactor da tela inicial
protocol HomeInteractorProtocol {
    /// Realiza a busca de produtos com base no texto fornecido.
    /// - Parameter product: Texto do produto a ser buscado.
    func search(product: String?)
    /// Carrega a próxima página de resultados da busca de produtos.
    func loadNextPage()
    /// Tras o estado inicial da tela.
    func initialState()
    /// Trata a seleção de um item de produto.
    /// - Parameter productItem: Detalhes do produto selecionado.
    func didSelect(productItem: ProductSearchDetail)
}

final class HomeInteractor: HomeInteractorProtocol {
    private let presenter: HomePresenterProtocol
    private let service: ProductSearchServiceProtocol
    private let itemsPerPage = 10
    private var page = 0
    private var searchProduct = ""

    /// Inicializador da classe `HomeInteractor`.
    /// - Parameters:
    /// - presenter: Instância do presenter que será utilizada pelo interactor.
    /// - service: Serviço de busca de produtos.
    init(presenter: HomePresenterProtocol,
         service: ProductSearchServiceProtocol) {
        self.presenter = presenter
        self.service = service
    }

    func search(product: String?) {
        presenter.presentLoading(shouldPresent: true)

        page = product != nil ? 0 : page
        searchProduct = product ?? searchProduct

        fetchProducts()
    }

    func loadNextPage() {
        fetchProducts()
    }

    func initialState() {
        presenter.presentInitialState()
    }

    func didSelect(productItem: ProductSearchDetail) {
        presenter.present(selectedItem: productItem)
    }

    private func fetchProducts() {
        service.fetchProducts(text: searchProduct, itemsPerPage: itemsPerPage, page: page) { [weak self] response in
            self?.presenter.presentLoading(shouldPresent: false)
            if response.results.isEmpty {
                self?.presenter.presentEmptyState()
            } else {
                self?.page += 1
                self?.presenter.present(productSearch: response)
            }
        } failure: { [presenter] in
            presenter.presentLoading(shouldPresent: false)
            presenter.presentError()
        }
    }
}
