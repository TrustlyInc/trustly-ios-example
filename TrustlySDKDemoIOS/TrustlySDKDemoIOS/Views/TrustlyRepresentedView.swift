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
    

}

extension TrustlyRepresentedView {
    func makeUIView(context: Context) -> TrustlySDK.TrustlyView {
        let trustlyView = TrustlyView()
        
        var establishData: Dictionary<AnyHashable,Any> = ["accessId": "A48B73F694C4C8EE6306",
                             "merchantId" : "110005514",
                             "currency" : "USD",
                             "amount" : "1.00",
                             "merchantReference" : "cac73df7-52b4-47d7-89d3-9628d4cfb65e",
                             "paymentType" : "Retrieval",
                             "returnUrl": "/returnUrl",
                             "cancelUrl": "/cancelUrl",
                             "requestSignature": "HT5mVOqBXa8ZlvgX2USmPeLns5o=",
                             "customer.name": "John",
                             "customer.address.country": "US",
                             "metadata.urlScheme": "demoapp://",
                             "description": "First Data Mobile Test",
                             "env": "sandbox",
                             "localUrl": "192.168.0.13:8000"]
        
        trustlyView.onChangeListener { (eventName, attributes) in
            print("onChangeListener: \(eventName) \(attributes)")
        }

        trustlyView.selectBankWidget(establishData: establishData) { (view, data) in
            print("returnParameters:\(data)")
            establishData = data
        }
        
        return trustlyView
    }
    
    func updateUIView(_ uiView: TrustlySDK.TrustlyView, context: Context) {
        
    }
}

struct TrustlyView_Previews: PreviewProvider {
    static var previews: some View {
        TrustlyRepresentedView()
    }
}
