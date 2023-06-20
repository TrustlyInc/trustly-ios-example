//
//  CartView.swift
//  TrustlySDKDemoIOS
//
//  Created by Marcos Rivereto on 15/06/23.
//

import SwiftUI

struct CartView<ViewModel>: View where ViewModel: CartViewModel {
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        
        NavigationView{
            VStack(alignment: .leading){
                HeaderView(title: "Shopping cart", imageName: "logo")
            
                List(viewModel.products){ product in
                    product
                    Divider()
                }.listStyle(.plain)
                    

                Divider()
                HStack{
                    Text("Subtotal:")
                    Spacer()
                    Text("$90.00")
                }.padding()
                
                NavigationLink{
//                    CartView().toolbarRole(.editor)
                } label: {
                    Text("Go to checkout")
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
        let products = [Product(title: "Prime Ultraspeed Stunt", description: "Size 10.5", image:"product", quantity: 1, price: 90.0)]
        CartView(viewModel: CartViewModel(selectedProducts: products))
    }
}
