//
//  CartView.swift
//  TrustlySDKDemoIOS
//
//  Created by Marcos Rivereto on 15/06/23.
//

import SwiftUI

struct CartView: View {
    let products = [Product(title: "Prime Ultraspeed Stunt", description: "Size 10.5", image:"product", quantity: 1, price: 90.0),
                    Product(title: "Prime Ultraspeed Stunt", description: "Size 10.5", image:"product", quantity: 1, price: 90.0),
                    Product(title: "Prime Ultraspeed Stunt", description: "Size 10.5", image:"product", quantity: 1, price: 90.0),
                    Product(title: "Prime Ultraspeed Stunt", description: "Size 10.5", image:"product", quantity: 1, price: 90.0),
                    Product(title: "Prime Ultraspeed Stunt", description: "Size 10.5", image:"product", quantity: 1, price: 90.0),
                    Product(title: "Prime Ultraspeed Stunt", description: "Size 10.5", image:"product", quantity: 1, price: 90.0),
                    Product(title: "Prime Ultraspeed Stunt", description: "Size 10.5", image:"product", quantity: 1, price: 90.0),
                    Product(title: "Prime Ultraspeed Stunt", description: "Size 10.5", image:"product", quantity: 1, price: 90.0)]

    
    var body: some View {
        
        NavigationView{
            VStack(alignment: .leading){
                Image("logo").padding()
                Text("Shopping cart")
                    .font(.custom("Open Sans", size: 28.0))
                    .fontWeight(.bold)
                    .foregroundColor(Color.ui.mainTitle)
                    .padding()
            
                List(products){ product in
                    ProductCellView(product: product).listRowSeparator(.hidden)
                    Divider()
                }.listStyle(.plain)
                    

                Divider()
                HStack{
                    Text("Subtotal:")
                    Spacer()
                    Text("$90.00")
                }.padding()
                
                Button {
                    print("Checkout")
                } label: {
                    Text("Checkout")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.ui.checkoutButton)
                        .border(Color.ui.checkoutButton)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding()
                }
            }
        }.navigationBarTitle("Purchase sneakers")
            .navigationBarTitleDisplayMode(.inline)
            
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}
