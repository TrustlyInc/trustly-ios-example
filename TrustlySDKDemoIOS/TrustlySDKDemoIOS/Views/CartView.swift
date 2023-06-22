//
//  CartView.swift
//  TrustlySDKDemoIOS
//
//  Created by Marcos Rivereto on 15/06/23.
//

import SwiftUI

struct CartView<ViewModel>: View where ViewModel: ProductViewModel {
    
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        
        NavigationStack {
            VStack(alignment: .leading){
                HeaderView(title: "Shopping cart", imageName: "logo")
                
                List($viewModel.selectedProducts){ $product in
                    ProductCellView(product: $product, cellType: .cart).listRowSeparator(.hidden)
                    
                    Divider()
                }.listStyle(.plain)
                
                HStack{
                    Text("Subtotal:")
                    Spacer()
                    Text(self.viewModel.calculateSubTotal().toCurrencyFormat())
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
            }.navigationBarTitle("Purchase sneakers")
                .navigationBarTitleDisplayMode(.inline)
            
        }.onAppear {
            self.viewModel.fetchSelectedProducts()
        }
            
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}
