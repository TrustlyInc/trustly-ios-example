//
//  ProductCellView.swift
//  TrustlySDKDemoIOS
//
//  Created by Marcos Rivereto on 15/06/23.
//

import SwiftUI

struct ProductCellView: View, Identifiable {
    var id = UUID()
    
    let image: String
    let title: String
    let description: String
    let quantity: Int
    let price: Double

    var body: some View {
        HStack(alignment: .top){
            Image(image)
                .resizable()
                .frame(width: 100, height: 100)
            
            VStack(alignment: .leading){
                Text(title)
                    .font(.custom("Open Sans", size: 16.0))
                    .fontWeight(.semibold)
                    .foregroundColor(Color.ui.productTitle)

                Spacer()
                Text(description)
                    .font(.custom("Open Sans", size: 16.0))
                    .fontWeight(.regular)
                    .foregroundColor(Color.ui.productDescription)
                HStack{
                    Text("Qty \(quantity)")
                        .font(.custom("Open Sans", size: 16.0))
                        .fontWeight(.regular)
                        .foregroundColor(Color.ui.productQuantity)
                    Spacer()
                    Text(price.toCurrencyFormat())
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

        ProductCellView(image:"product", title: "Prime Ultraspeed Stunt", description: "Size 10.5", quantity: 1, price: 90.0).previewLayout(.fixed(width: 300, height: 100))
    }
}
