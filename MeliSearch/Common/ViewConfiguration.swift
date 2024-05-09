import Foundation

protocol ViewConfiguration {
    func configViews()
    func buildViewHierarchy()
    func setupConstraints()
}

extension ViewConfiguration {
    func buildLayout() {
        configViews()
        buildViewHierarchy()
        setupConstraints()
    }
}
