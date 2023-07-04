//
//  CartView.swift
//  TrustlySDKDemoIOS
//
//  Created by Marcos Rivereto on 15/06/23.
//

import SwiftUI

struct CartView<ViewModel>: View where ViewModel: ProductViewModelProtocol {
    
    @EnvironmentObject var viewModel: ViewModel
    @State private var isShowingCheckoutView = false
    
    var body: some View {
        
        VStack(alignment: .leading){
            HeaderView(title: "Shopping cart", imageName: "logo")
            
            List($viewModel.selectedProducts){ $product in
                ProductCellView(product: $product, cellType: .cart).listRowSeparator(.hidden)
                
            }.listStyle(.plain)
            
            Divider()
            
            HStack{
                Text("Subtotal:")
                Spacer()
                Text(self.viewModel.calculateSubTotal().toCurrencyFormat())
            }.padding()
            
            Button {
                isShowingCheckoutView.toggle()
                
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
            .navigationDestination(isPresented: $isShowingCheckoutView) {
                CheckoutView(checkoutViewModel: CheckoutViewModel(products: viewModel.selectedProducts),
                             paymentViewModel: PaymentViewModel()
                ).toolbarRole(.editor)
            }.onAppear {
                self.viewModel.fetchSelectedProducts()
            }
            
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView<ProductViewModel>().environmentObject(ProductViewModel())
    }
}
