//
//  CheckoutView.swift
//  TrustlySDKDemoIOS
//
//  Created by Marcos Rivereto on 16/06/23.
//

import SwiftUI

struct CheckoutView: View {
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
                HeaderView(title: "Checkout", imageName: "logo")
                List(products){ product in
                    ProductCellView(product: product).listRowSeparator(.hidden)
                    Divider()
                }.listStyle(.plain)
                    
                Divider()
                Text("Payment method")
                    .font(.custom("Open Sans", size: 16.0))
                    .fontWeight(.semibold)
                    .foregroundColor(Color.ui.subTitle)
                    .padding()
                
                Divider()
                FooterView()
                
                Button {
                    print("Checkout")
                } label: {
                    Text("Place order")
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

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView()
    }
}
