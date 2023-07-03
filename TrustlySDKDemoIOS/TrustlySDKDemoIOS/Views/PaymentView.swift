//
//  PaymentView.swift
//  TrustlySDKDemoIOS
//
//  Created by Marcos Rivereto on 27/06/23.
//

import SwiftUI

struct PaymentView<ViewModel>: View where ViewModel: CheckoutViewModelProtocol {
    
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        TrustlyRepresentedView(establishData: $viewModel.establishData,
                               paymentMethodRendering: .lightBox,
                               onReturn: self.onSuccess,
                               onCancel: self.onError).frame(minHeight: 550, maxHeight: .infinity)
    }
    
    private func onSuccess(response: [String:String]) -> Void {
        print("onSuccess: \(response)")
    }
    
    private func onError(response: [String:String]) -> Void {
        print("onError: \(response)")
    }
}

struct PaymentView_Previews: PreviewProvider {
    static var previews: some View {
        let productsList = [Product(title: "Prime Ultraspeed Stunt", description: "Size 10.5", image:"product", quantity: 2, price: 90.0)]
        PaymentView<CheckoutViewModel>().environmentObject(CheckoutViewModel(products: productsList))
        
    }
}
