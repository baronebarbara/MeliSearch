import SwiftUI

struct RemoteImageView: UIViewRepresentable {
    let url: URL
    let placeholder: UIImage?

    func makeUIView(context: Context) -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }

    func updateUIView(_ uiView: UIImageView, context: Context) {
        uiView.loadImage(from: url, placeholder: placeholder)
    }
}
