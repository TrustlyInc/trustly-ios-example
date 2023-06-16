//
//  ProductCellView.swift
//  TrustlySDKDemoIOS
//
//  Created by Marcos Rivereto on 15/06/23.
//

import SwiftUI

struct ProductCellView: View {
    
    let product: Product

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
                    Text("Qty \(product.quantity)")
                        .font(.custom("Open Sans", size: 16.0))
                        .fontWeight(.regular)
                        .foregroundColor(Color.ui.productQuantity)
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
    
}

struct ProductCellView_Previews: PreviewProvider {
    static var previews: some View {
        let product = Product(title: "Prime Ultraspeed Stunt", description: "Size 10.5", image:"product", quantity: 1, price: 90.0)
        ProductCellView(product: product).previewLayout(.fixed(width: 300, height: 100))
    }
}
