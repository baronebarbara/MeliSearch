import UIKit

final class HomeViewCell: UICollectionViewCell {
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 16
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
        image.image = UIImage(named: "mercao-livre-logo")
        image.layer.cornerRadius = 12
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = UIColor(named: Strings.Color.background)
        label .text = "Naldinho"
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(named: Strings.Color.lightGray)
        label.text = "R$ 500,00"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        buildLayout()
    }
    
    required init?(coder: NSCoder) { nil }
}

extension HomeViewCell: ViewConfiguration {
    func configViews() {
        
    }
    
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
            
            productImage.heightAnchor.constraint(equalToConstant: 150),
            productImage.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
}
