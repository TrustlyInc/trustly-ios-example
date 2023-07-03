//
//  ProductViewModel.swift
//  TrustlySDKDemoIOS
//
//  Created by Marcos Rivereto on 20/06/23.
//

import Foundation

protocol ProductViewModelProtocol: ObservableObject {
    var products: [Product] { get set }
    var selectedProducts: [Product] { get set }
    
    func fetchProducts()
    func fetchSelectedProducts()
    func calculateSubTotal() -> Double
    func disableButton() -> Bool
    
}

class ProductViewModel: ProductViewModelProtocol {
    @Published var products: [Product] = [Product]()
    @Published var selectedProducts: [Product] = [Product]()
        
    let productsList = [Product(title: "Prime Ultraspeed Stunt", description: "Size 10.5", image:"product", quantity: 0, price: 90.0),
                    Product(title: "Prime Ultraspeed Stunt", description: "Size 10.5", image:"product", quantity: 0, price: 90.0),
                    Product(title: "Prime Ultraspeed Stunt", description: "Size 10.5", image:"product", quantity: 0, price: 90.0),
                    Product(title: "Prime Ultraspeed Stunt", description: "Size 10.5", image:"product", quantity: 0, price: 90.0),
                    Product(title: "Prime Ultraspeed Stunt", description: "Size 10.5", image:"product", quantity: 0, price: 90.0),
                    Product(title: "Prime Ultraspeed Stunt", description: "Size 10.5", image:"product", quantity: 0, price: 90.0),
                    Product(title: "Prime Ultraspeed Stunt", description: "Size 10.5", image:"product", quantity: 0, price: 90.0),
                    Product(title: "Prime Ultraspeed Stunt", description: "Size 10.5", image:"product", quantity: 0, price: 90.0),
                    Product(title: "Prime Ultraspeed Stunt", description: "Size 10.5", image:"product", quantity: 0, price: 90.0),
                    Product(title: "Prime Ultraspeed Stunt", description: "Size 10.5", image:"product", quantity: 0, price: 90.0),
                    Product(title: "Prime Ultraspeed Stunt", description: "Size 10.5", image:"product", quantity: 0, price: 90.0),
                    Product(title: "Prime Ultraspeed Stunt", description: "Size 10.5", image:"product", quantity: 0, price: 90.0),
                    Product(title: "Prime Ultraspeed Stunt", description: "Size 10.5", image:"product", quantity: 0, price: 90.0),
                    Product(title: "Prime Ultraspeed Stunt", description: "Size 10.5", image:"product", quantity: 0, price: 90.0),
                    Product(title: "Prime Ultraspeed Stunt", description: "Size 10.5", image:"product", quantity: 0, price: 90.0),
                    Product(title: "Prime Ultraspeed Stunt", description: "Size 10.5", image:"product", quantity: 0, price: 90.0),
                    Product(title: "Prime Ultraspeed Stunt", description: "Size 10.5", image:"product", quantity: 0, price: 90.0)]
    
    
    func fetchProducts() {
        self.productsList.forEach {
            products.append($0)
        }
    }
    
    func fetchSelectedProducts() {
        self.selectedProducts = products.filter { product in return product.quantity > 0 }
    }
    
    func calculateSubTotal() -> Double {
        return self.selectedProducts.map{ Double($0.quantity) * $0.price}.reduce(0.0, +)
    }
    
    func disableButton() -> Bool {
        return (products.filter { product in return product.quantity > 0 }).count <= 0
    }
}
