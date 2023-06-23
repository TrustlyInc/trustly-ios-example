//
//  FooterView.swift
//  TrustlySDKDemoIOS
//
//  Created by Marcos Rivereto on 16/06/23.
//

import SwiftUI

struct FooterView<ViewModel>: View where ViewModel: CheckoutViewModelProtocol {
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack{
            HStack{
                Text("Subtotal:")
                Spacer()
                Text(viewModel.calculateSubTotal().toCurrencyFormat())
            }.padding()
            HStack{
                Text("Shipping:")
                Spacer()
                Text(viewModel.getShippingFormatted())
            }.padding(.leading, 15)
                .padding(.trailing, 15)
            
            Divider()
            
            HStack{
                Text("Total:")
                Spacer()
                Text(viewModel.calculateTotal().toCurrencyFormat())
            }.padding(.all)

        }
    }
}

struct FooterView_Previews: PreviewProvider {
    static var previews: some View {
        let productsList = [Product(title: "Prime Ultraspeed Stunt", description: "Size 10.5", image:"product", quantity: 0, price: 90.0)]

        FooterView(viewModel: CheckoutViewModel(products: productsList)).previewLayout(.sizeThatFits)
    }
}
