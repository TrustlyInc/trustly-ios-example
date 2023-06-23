//
//  ProductCellView.swift
//  TrustlySDKDemoIOS
//
//  Created by Marcos Rivereto on 15/06/23.
//

import SwiftUI

enum ProductCellType{
    case cart
    case catalog
    case checkout
}

struct ProductCellView: View, Identifiable {
    var id = UUID()
  
    @Binding var product: Product
    let cellType: ProductCellType

    var body: some View {
        HStack(alignment: .top){
            Image(product.image)
                .resizable()
                .frame(width: 100, height: 100)

            VStack(alignment: .leading){
                Text(product.title)
                    .font(.custom("Open Sans", size: 16.0))
                    .fontWeight(.semibold)
                    .foregroundColor(Color.ui.productTitle)

                Spacer()
                Text(product.description)
                    .font(.custom("Open Sans", size: 16.0))
                    .fontWeight(.regular)
                    .foregroundColor(Color.ui.productDescription)
                HStack{
                    self.showQuantityToReadOrSelect()
                    Spacer()
                    Text(product.price.toCurrencyFormat())
                        .font(.custom("Open Sans", size: 16.0))
                        .fontWeight(.semibold)
                        .foregroundColor(Color.ui.productPrice)
                        .padding(.trailing, 5)
                }
            }
        }.frame(maxHeight: 100)
            
    }
    
    private func showQuantityToReadOrSelect() -> AnyView {
        
        let textQuantity = Text("Qty: \(product.quantity)")
            .font(.custom("Open Sans", size: 16.0))
            .fontWeight(.regular)
            .foregroundColor(Color.ui.productQuantity)
        
        switch self.cellType {
        case .cart, .checkout:
            return AnyView(textQuantity)
            
        case .catalog:
            return  AnyView(Stepper( value: $product.quantity, in: 0...5, step: 1){
                textQuantity
            }.fixedSize())
        }
        
    }
    
}

struct ProductCellView_Previews: PreviewProvider {
    static var previews: some View {
        @State var product = Product(title: "Prime Ultraspeed Stunt", description: "Size 10.5", image:"product", quantity: 0, price: 90.0)
        ProductCellView(product: $product, cellType: .catalog).previewLayout(.fixed(width: 300, height: 100))
    }
}
