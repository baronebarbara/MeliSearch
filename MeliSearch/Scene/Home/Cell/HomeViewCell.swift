import UIKit

final class HomeViewCell: UICollectionViewCell {
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 6
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var labelsStack: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 4
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var productImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 12
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor(named: Strings.Color.background)
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(named: Strings.Color.lightGray)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        buildLayout()
    }
    
    required init?(coder: NSCoder) { nil }
    
    override func prepareForReuse() {
        productImage.image = nil
        titleLabel.text = nil
        priceLabel.text = nil
    }
    
    func setup(productSearch: ProductSearchDetail) {
        if let productImageURL = URL(string: productSearch.thumbnail) {
            productImage.loadImage(from: productImageURL, placeholder: UIImage(named: Strings.Images.logo))
        }
        titleLabel.text = productSearch.title
        priceLabel.text = productSearch.price.currencyFormat()
    }
}

extension HomeViewCell: ViewConfiguration {
    func configViews() {}
    
    func buildViewHierarchy() {
        addSubview(mainStack)
        mainStack.addArrangedSubview(productImage)
        mainStack.addArrangedSubview(labelsStack)
        labelsStack.addArrangedSubview(titleLabel)
        labelsStack.addArrangedSubview(priceLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: topAnchor),
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            productImage.heightAnchor.constraint(equalToConstant: 120),
            productImage.widthAnchor.constraint(equalToConstant: 120)
        ])
    }
}
