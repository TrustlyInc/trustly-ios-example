//
//  CheckoutViewModel.swift
//  TrustlySDKDemoIOS
//
//  Created by Marcos Rivereto on 23/06/23.
//

import Foundation

protocol CheckoutViewModelProtocol: ObservableObject {
    var products: [Product] { get set }
    var establishData: Dictionary<AnyHashable,Any>  { get set }
    
    func calculateSubTotal() -> Double
    func calculateTotal() -> Double
    func calculateShipping() -> Double
    func getShippingFormatted() -> String
    func disableCheckout() -> Bool
    func updateEstablishWithValue()
    
}

class CheckoutViewModel: CheckoutViewModelProtocol {

    @Published var products: [Product] = [Product]()
    @Published var establishData: Dictionary<AnyHashable,Any>
    
    init(products: [Product]) {
        self.products = products
        
        self.establishData = ["accessId": "A48B73F694C4C8EE6306",
                              "merchantId" : "110005514",
                              "currency" : "USD",
                              "merchantReference" : "cac73df7-52b4-47d7-89d3-9628d4cfb65e",
                              "paymentType" : "Retrieval",
                              "returnUrl": "/returnUrl",
                              "cancelUrl": "/cancelUrl",
                              "requestSignature": "HT5mVOqBXa8ZlvgX2USmPeLns5o=",
                              "customer.name": "John",
                              "customer.address.country": "US",
                              "metadata.urlScheme": "basicCheckout://",
                              "description": "First Data Mobile Test",
                              "env": "sandbox",
                              "localUrl": "192.168.0.13:8000"]
    }

    
    func calculateSubTotal() -> Double {
        return self.products.map{ Double($0.quantity) * $0.price}.reduce(0.0, +)
    }
    
    
    func calculateShipping() -> Double {
        return 0.00
    }

    
    func calculateTotal() -> Double {
        let subTotal = self.products.map{ Double($0.quantity) * $0.price}.reduce(0.0, +)
        let shipping = self.calculateShipping()
        
        return subTotal + shipping
    }
    
    func getShippingFormatted() -> String {
        let shipping = self.calculateShipping()
        
        if shipping <= 0 {
            return "Free"
        }
        
        return shipping.toCurrencyFormat()
    }
    
    func disableCheckout() -> Bool {
        
        if establishData.keys.contains("paymentProviderId") {
            return false
        }
        
        return true
    }
    
    func updateEstablishWithValue() {
        establishData["amount"] = String(self.calculateTotal())
    }
}
