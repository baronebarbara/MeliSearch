import SwiftUI

struct Product {
    var id: Int
    var name: String
    var description: String
    var price: Double
}

struct ProductDetailsView: View {
    var product: Product

    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "photo")
                .frame(width: 375, height: 300)
                .background(Color.red)
            Text(product.name)
                .font(.title).bold()
            Text(product.description)
                .font(.title2)
            Text("Valor: R$ \(product.price, specifier: "%.2f")")
                .font(.headline)
        }
    }
}

#Preview {
    ProductDetailsView(product: Product(id: 0, name: "Batata", description: "eles sao legais e estao na floresta brincando", price: 20.00))
}
