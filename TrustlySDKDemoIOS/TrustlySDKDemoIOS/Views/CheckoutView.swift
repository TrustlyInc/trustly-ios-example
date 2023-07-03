//
//  CheckoutView.swift
//  TrustlySDKDemoIOS
//
//  Created by Marcos Rivereto on 16/06/23.
//

import SwiftUI

struct CheckoutView<CheckoutViewModel, PaymentViewModel>: View where CheckoutViewModel: CheckoutViewModelProtocol, PaymentViewModel: PaymentViewModelProtocol {

    @ObservedObject var checkoutViewModel: CheckoutViewModel
    @ObservedObject var paymentViewModel: PaymentViewModel
    @State private var isShowingPaymentView = false
    @State private var isShowingStatusView = false

    
    var body: some View {
        
        NavigationView {
            VStack(alignment: .leading){
                HeaderView(title: "Checkout", imageName: "logo")
                
                List {
                    ForEach($checkoutViewModel.products) { $product in
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

                        PaymentMethodView(viewModel: checkoutViewModel, paymentAuthorized: paymentViewModel.paymentAuthorized())
                        
                        Divider()
                        FooterView(viewModel: checkoutViewModel)
                        
                        Button {
                            if (paymentViewModel.paymentAuthorized()) {
                                isShowingStatusView.toggle()
                                
                            } else {
                                isShowingPaymentView.toggle()
                            }
                            
                        } label: {
                            Text("Place order")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.ui.checkoutButton)
                                .border(Color.ui.checkoutButton)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .padding()
                        }.disabled(checkoutViewModel.disableCheckout())
                        
                    }.listRowSeparator(.hidden)
                }.listStyle(.plain)
                
            }.navigationBarTitle("Purchase sneakers")
                .navigationBarTitleDisplayMode(.inline)
                .frame(maxHeight: .infinity)
                .navigationDestination(isPresented: $isShowingPaymentView) {
                    PaymentView(viewModel: paymentViewModel, establishData: $checkoutViewModel.establishData).toolbarRole(.editor)
                }
                .navigationDestination(isPresented: $isShowingStatusView) {
                    StatusView(statusViewModel: StatusViewModel(transaction: paymentViewModel.transaction)).toolbarRole(.editor)
                }

        }.onAppear {
            checkoutViewModel.updateEstablishWithValue()
        }
    }

}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        let productsList = [Product(title: "Prime Ultraspeed Stunt", description: "Size 10.5", image:"product", quantity: 2, price: 90.0)]
        
        CheckoutView(checkoutViewModel: CheckoutViewModel(products: productsList), paymentViewModel: PaymentViewModel())
    }
}
