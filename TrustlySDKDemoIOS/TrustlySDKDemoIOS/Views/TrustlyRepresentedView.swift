//
//  TrustlyRepresentedView.swift
//  TrustlySDKDemoIOS
//
//  Created by Marcos Rivereto on 26/06/23.
//

import SwiftUI
import TrustlySDK

enum PaymentMethodRendering {
    case widget
    case lightBox
}

struct TrustlyRepresentedView: UIViewRepresentable {

    typealias UIViewType = UIView
    typealias LightBoxOnReturn = ([String: String]) -> Void
    
    @Binding var establishData: Dictionary<AnyHashable,Any>
    var paymentMethodRendering: PaymentMethodRendering
    
}

extension TrustlyRepresentedView {
    
    
    func makeUIView(context: Context) -> UIView {
            
        switch self.paymentMethodRendering {
        case .widget:
            return self.buildWidget()
        case.lightBox:
            return self.buildLightBox()
        }
        
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
    
    private func buildWidget() -> UIView  {
        let trustlyView = TrustlyView()

        trustlyView.selectBankWidget(establishData: establishData) { (view, data) in
            establishData = data
        }
        
        return trustlyView
    }
    
    private func buildLightBox() -> UIView  {
        let trustlyLightboxPanel = TrustlyView()
        
        guard let trustlyView = trustlyLightboxPanel.establish(establishData: establishData,
                                                            onReturn: {(payWithMyBank, returnParameters)->Void in
                    let response = returnParameters as! [String:String]

                    if let onReturn = self.onReturn {
                        onReturn(response)
                    }
                     
                 }, onCancel: {(payWithMyBank, returnParameters)->Void in
                     let response = returnParameters as! [String:String]
                     
                     if let onCancel = self.onCancel {
                         onCancel(response)
                     }
                     
                 }) else { return self.buildErrorLabel( )}
        
        return trustlyView
    }
    
    private func buildErrorLabel() -> UILabel {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        label.center = CGPoint(x: 160, y: 285)
        label.textAlignment = .center
        label.text = "Error to load lightBox"
        
        return label
    }
}

struct TrustlyView_Previews: PreviewProvider {
    static let productsList = [Product(title: "Prime Ultraspeed Stunt", description: "Size 10.5", image:"product", quantity: 2, price: 90.0)]
    
    @State static var establishData: Dictionary<AnyHashable,Any> = [:]
    
    static var previews: some View {
        TrustlyRepresentedView(establishData: $establishData, paymentMethodRendering: .widget)

    }
}
