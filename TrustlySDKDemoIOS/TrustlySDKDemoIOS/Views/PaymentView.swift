//
//  PaymentView.swift
//  TrustlySDKDemoIOS
//
//  Created by Marcos Rivereto on 27/06/23.
//

import SwiftUI

struct PaymentView<ViewModel>: View where ViewModel: PaymentViewModelProtocol {
    
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: ViewModel
    @Binding var establishData: Dictionary<AnyHashable,Any>
    
    var body: some View {
        TrustlyRepresentedView(establishData: $establishData,
                               paymentMethodRendering: .lightBox,
                               onReturn: self.handleTransactionResponse,
                               onCancel: self.handleTransactionResponse)
        .frame(minHeight: 550, maxHeight: .infinity)
        .navigationBarHidden(true)
    }
    
    private func handleTransactionResponse(response: [String:String]) -> Void {
        print("handleTransactionResponse: \(response)")
        viewModel.createTransaction(response: response)
        dismiss()
    }
    
}

struct PaymentView_Previews: PreviewProvider {
    @State static var establish = [AnyHashable: Any]()
    
    static var previews: some View {
        PaymentView(viewModel: PaymentViewModel(), establishData: $establish)
        
    }
}
