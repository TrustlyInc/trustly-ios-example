//
//  CartViewModel.swift
//  TrustlySDKDemoIOS
//
//  Created by Marcos Rivereto on 20/06/23.
//

import Foundation

protocol CartViewModelProtocol: ObservableObject {
    var products: [ProductCellView] { get }
    func fetchSelectedProducts()
}

class CartViewModel: CartViewModelProtocol {
    
    @Published var products: [ProductCellView] = [ProductCellView]()
    private var selectedProducts: [Product]
    
    
    init(selectedProducts: [Product]) {
        self.selectedProducts = selectedProducts
    }
    
    func fetchSelectedProducts() {
        self.selectedProducts.forEach {
            products.append(ProductCellView(image: $0.image,
                                            title: $0.title,
                                            description: $0.description,
                                            price: $0.price,
                                            cellType: .cart))
        }
    }
}
