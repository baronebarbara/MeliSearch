import SwiftUI

struct Product {
    var id: Int
    var name: String
    var price: Double
    var imageUrl: URL?
}

struct ProductDetailsView: View {
    var product: Product
    
    var body: some View {
        VStack(spacing: 16) {
            if let imageUrl = product.imageUrl {
                RemoteImageView(url: imageUrl, placeholder: UIImage(systemName: Strings.Images.logo))
                    .frame(width: 375, height: 300)
            } else {
                Image(Strings.Images.logo)
                    .frame(width: 375, height: 300)
            }
            Text(product.name)
                .font(.title).bold()
                .foregroundColor(Color(Strings.Color.background, bundle: nil))
            Text("Valor: R$ \(product.price, specifier: "%.2f")")
                .font(.headline)
        }
        .padding()
    }
}

#Preview {
    ProductDetailsView(product: Product(id: 0, name: "Samsung Galaxy", price: 20.00))
}
