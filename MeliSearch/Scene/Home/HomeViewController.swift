import SwiftUI
import UIKit

protocol HomeViewControllerProtocol: AnyObject {
    func startLoading()
    func stopLoading()
    func show(search: ProductSearch)
    func showProductSearch(shouldShow: Bool)
    func showEmpty()
    func showError()
    func hideEmpty()
    func hideError()
    func showInitialState(shouldShow: Bool)
    func showErrorCell()
    func startLoadingCell()
    func stopLoadingCell()
}

final class HomeViewController: UIViewController {
    private lazy var searchView: UISearchBar = {
        let search = UISearchBar()
        search.translatesAutoresizingMaskIntoConstraints = false
        search.layer.cornerRadius = 16
        search.placeholder = Strings.HomeStrings.searchPlaceholderText
        search.delegate = self
        return search
    }()
    
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var productsLabel: UILabel = {
        let label = UILabel()
        label.text = Strings.HomeStrings.productsLabelText
        label.textColor = UIColor(named: Strings.Color.background)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var collection: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(HomeViewCell.self, forCellWithReuseIdentifier: "HomeViewCell")
        collection.dataSource = self
        collection.delegate = self
        collection.showsVerticalScrollIndicator = false
        return collection
    }()
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 12
        return layout
    }()
    
    private lazy var loading: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    private var productsSearch: [ProductSearchDetail] = []
    private var totalResults: Int = 0
    private let interactor: HomeInteractorProtocol
    
    init(interactor: HomeInteractorProtocol) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildLayout()
        title = Strings.HomeStrings.title
        interactor.initialState()
    }
    
    private func shouldLoadNextPage(row: Int) -> Bool {
        row == productsSearch.endIndex - 1 && totalResults > productsSearch.count
    }
}

extension HomeViewController: ViewConfiguration {
    func configViews() {
        view.backgroundColor = .white
    }
    
    func buildViewHierarchy() {
        view.addSubview(searchView)
        view.addSubview(mainStack)
        mainStack.addArrangedSubview(productsLabel)
        mainStack.addArrangedSubview(collection)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            searchView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            searchView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            mainStack.topAnchor.constraint(equalTo: searchView.bottomAnchor, constant: 24),
            mainStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            mainStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            mainStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productsSearch.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeViewCell", for: indexPath) as? HomeViewCell else {
            return UICollectionViewCell()
        }
        
        cell.setup(productSearch: productsSearch[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        interactor.didSelect(productItem: productsSearch[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard shouldLoadNextPage(row: indexPath.row) else { return }
        interactor.loadNextPage()
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height: CGFloat = 200
        
        return CGSize(width: width, height: height)
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        productsSearch = []
        interactor.search(product: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        interactor.initialState()
    }
}

extension HomeViewController: HomeViewControllerProtocol {
    func startLoading() {
        view.addSubview(loading)
        
        NSLayoutConstraint.activate([
            loading.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loading.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        loading.startAnimating()
    }
    
    func stopLoading() {
        loading.stopAnimating()
        loading.removeFromSuperview()
    }
    
    func show(search: ProductSearch) {
        totalResults = search.totalResults
        productsSearch.append(contentsOf: search.results)
        collection.reloadData()
    }
    
    func showProductSearch(shouldShow: Bool) {
        collection.isHidden = !shouldShow
    }
    
    func showEmpty() {
        
    }
    
    func showError() {
        
    }
    
    func hideEmpty() {
        
    }
    
    func hideError() {
        
    }
    
    func showInitialState(shouldShow: Bool) {
        
    }
    
    func showErrorCell() {
        
    }
    
    func startLoadingCell() {
        
    }
    
    func stopLoadingCell() {
        
    }
}
