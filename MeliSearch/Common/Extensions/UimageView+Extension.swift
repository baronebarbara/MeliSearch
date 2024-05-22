import UIKit

extension UIImageView {
    func loadImage(from url: URL, placeholder: UIImage?) {
        self.image = placeholder
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self.image = image
            }
        }.resume()
    }
}
