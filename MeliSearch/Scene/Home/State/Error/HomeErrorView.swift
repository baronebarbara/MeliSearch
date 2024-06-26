import UIKit

protocol ErrorViewDelegateProtocol: AnyObject {
    func didTapButton()
}

final class HomeErrorView: UIView {
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 24
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var imageErrorView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: Strings.Images.chateado)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = UIColor(named: Strings.Color.lightGray)
        label.text = Strings.ErrorStrings.title
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.textColor = UIColor(named: Strings.Color.lightGray)
        label.text = Strings.ErrorStrings.message
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var mainButton: UIButton = {
        let button = UIButton()
        button.setTitle(Strings.ErrorStrings.button, for: .normal)
        button.setTitleColor(UIColor(named: Strings.Color.background), for: .normal)
        button.addTarget(self, action: #selector(actionButton), for: .touchUpInside)
        return button
    }()
    
    weak var delegate: ErrorViewDelegateProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    @objc
    private func actionButton() {
        delegate?.didTapButton()
    }
}

extension HomeErrorView: ViewConfiguration {
    func configViews() {
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func buildViewHierarchy() {
        addSubview(mainStack)
        mainStack.addArrangedSubview(imageErrorView)
        mainStack.addArrangedSubview(titleLabel)
        mainStack.addArrangedSubview(descriptionLabel)
        mainStack.addArrangedSubview(mainButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: topAnchor, constant: 32),
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            
            imageErrorView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
}
