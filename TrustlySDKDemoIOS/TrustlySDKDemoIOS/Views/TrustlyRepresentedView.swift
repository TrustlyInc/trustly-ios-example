//
//  TrustlyRepresentedView.swift
//  TrustlySDKDemoIOS
//
//  Created by Marcos Rivereto on 26/06/23.
//

import SwiftUI
import TrustlySDK

struct TrustlyRepresentedView: UIViewRepresentable {

    typealias UIViewType = TrustlyView
    
    @Binding var establishData: Dictionary<AnyHashable,Any>
    
}

extension TrustlyRepresentedView {
    
    
    func makeUIView(context: Context) -> TrustlySDK.TrustlyView {
        let trustlyView = TrustlyView()

        trustlyView.selectBankWidget(establishData: establishData) { (view, data) in
            establishData = data
        }
        
        return trustlyView
    }
    
    func updateUIView(_ uiView: TrustlySDK.TrustlyView, context: Context) {
        
    }
}

struct TrustlyView_Previews: PreviewProvider {
    static let productsList = [Product(title: "Prime Ultraspeed Stunt", description: "Size 10.5", image:"product", quantity: 2, price: 90.0)]
    
    @State static var establishData: Dictionary<AnyHashable,Any> = [:]
    
    static var previews: some View {
        TrustlyRepresentedView(establishData: $establishData)

    }
}
