//
//  PaymentMethodView.swift
//  TrustlySDKDemoIOS
//
//  Created by Marcos Rivereto on 27/06/23.
//

import SwiftUI

struct PaymentMethodView<ViewModel>: View where ViewModel: CheckoutViewModelProtocol {
    
    @ObservedObject var viewModel: ViewModel
    @State var selected:Int = 1
    var paymentAuthorized: Bool
    
    var body: some View {
        VStack {
            
            HStack {
                Picker(selection: $selected, label: Text("")) {
                            Text("Online Banking").tag(1)
                        }
                        .pickerStyle(.segmented)
                
                Image("icon_payments")

            }.padding()
            
            Divider()
            
            if (paymentAuthorized) {
                HStack {
                    Image("icon_success")
                        .padding(.top)
                        .padding()
                    Text("Bank selected")
                        .font(.custom("Open Sans", size: 28.0))
                        .fontWeight(.semibold)
                        .foregroundColor(Color.ui.subTitle)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top)
                        .padding()
                }
                .frame(width: .infinity)
                .overlay(RoundedRectangle(cornerRadius: 6)
                .stroke(Color.ui.boxBorder, lineWidth: 1))
                .padding()
                
            } else {
                self.buildWidget()
            }
            
        }.overlay(RoundedRectangle(cornerRadius: 6)
            .stroke(Color.ui.boxBorder, lineWidth: 1))
    }
    
    private func buildWidget() -> some View {
        return  TrustlyRepresentedView(establishData: $viewModel.establishData, paymentMethodRendering: .widget)
            .frame(minHeight: 550, maxHeight: .infinity)
    }
}


struct PaymentMethodView_Previews: PreviewProvider {
    static var previews: some View {
        let productsList = [Product(id: "14", title: "Prime Ultraspeed Stunt", description: "Size 10.5", image:"product", quantity: 2, price: 90.0)]
        
        PaymentMethodView(viewModel: CheckoutViewModel(products: productsList), paymentAuthorized: true)

    }
}
