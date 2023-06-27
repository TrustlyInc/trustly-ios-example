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
    
    var body: some View {
        VStack {
            
            Picker(selection: $selected, label: Text("Favorite Fruit")) {
                        Text("Online Banking").tag(1)
                        Text("Credit card").tag(2)
                    }
                    .pickerStyle(.segmented)
            
            TrustlyRepresentedView()
                .frame(minHeight: 550, maxHeight: .infinity)
        }
    }
}


struct PaymentMethodView_Previews: PreviewProvider {
    static var previews: some View {
        let productsList = [Product(title: "Prime Ultraspeed Stunt", description: "Size 10.5", image:"product", quantity: 2, price: 90.0)]
        
        PaymentMethodView(viewModel: CheckoutViewModel(products: productsList))

    }
}
