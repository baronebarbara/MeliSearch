import UIKit

final class HomeErrorView: UIView {
    private lazy var imageErrorView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: Strings.Images.logo)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = UIColor(named: Strings.Color.lightGray)
        label.text = "Parece que deu algo errado por aqui!"
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.textColor = UIColor(named: Strings.Color.lightGray)
        label.text = "Você pode tentar novamente mais tarde"
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var mainButton: UIButton = {
        let button = UIButton()
        button.setTitle("Tentar novamente", for: .normal)
        button.setTitleColor(UIColor(named: Strings.Color.background), for: .normal)
        button.addTarget(self, action: #selector(actionButton), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    @objc
    private func actionButton() {
        
    }
}

extension HomeErrorView: ViewConfiguration {
    func configViews() {
        
    }
    
    func buildViewHierarchy() {
        
    }
    
    func setupConstraints() {
        
    }
}
