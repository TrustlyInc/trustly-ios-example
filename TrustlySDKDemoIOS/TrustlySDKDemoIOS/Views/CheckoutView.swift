//
//  CheckoutView.swift
//  TrustlySDKDemoIOS
//
//  Created by Marcos Rivereto on 16/06/23.
//

import SwiftUI

struct CheckoutView<ViewModel>: View where ViewModel: CheckoutViewModelProtocol {

    @ObservedObject var viewModel: ViewModel

    
    var body: some View {
        
        NavigationView{
            VStack(alignment: .leading){
                HeaderView(title: "Checkout", imageName: "logo")
                List {
                    ForEach($viewModel.products) { $product in
                        ProductCellView(product: $product, cellType: .checkout).listRowSeparator(.hidden)
                    }
                    
                    VStack{
                        Divider()

                        Text("Payment method")
                            .font(.custom("Open Sans", size: 16.0))
                            .fontWeight(.semibold)
                            .foregroundColor(Color.ui.subTitle)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 5)
                            .padding(.top)

                        PaymentMethodView(viewModel: viewModel)
                        
                        Divider()
                        FooterView(viewModel: viewModel)
                        
                        Button {
                            
                        } label: {
                            Text("Place order")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.ui.checkoutButton)
                                .border(Color.ui.checkoutButton)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .padding()
                        }.disabled(viewModel.disableCheckout())
                        
                    }.listRowSeparator(.hidden)
                }.listStyle(.plain)
                    

            }
        }.navigationBarTitle("Purchase sneakers")
            .navigationBarTitleDisplayMode(.inline)
            .frame(maxHeight: .infinity)
        
            
    }

}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        let productsList = [Product(title: "Prime Ultraspeed Stunt", description: "Size 10.5", image:"product", quantity: 2, price: 90.0)]
        
        CheckoutView(viewModel: CheckoutViewModel(products: productsList))
    }
}
