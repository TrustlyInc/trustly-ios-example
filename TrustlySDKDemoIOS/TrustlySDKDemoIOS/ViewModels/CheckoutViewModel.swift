//
//  CheckoutViewModel.swift
//  TrustlySDKDemoIOS
//
//  Created by Marcos Rivereto on 23/06/23.
//

import Foundation

protocol CheckoutViewModelProtocol: ObservableObject {
    var products: [Product] { get set }
    
    func calculateSubTotal() -> Double
    func calculateTotal() -> Double
    func calculateShipping() -> Double
    func getShippingFormatted() -> String
    
}

class CheckoutViewModel: CheckoutViewModelProtocol {

    @Published var products: [Product] = [Product]()
    
    init(products: [Product]) {
        self.products = products
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
}
