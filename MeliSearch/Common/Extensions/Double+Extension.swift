import Foundation

extension Double {
    func currencyFormat() -> String {
        let number = NSNumber(value: self)
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter.string(from: number) ?? ""
    }
}
