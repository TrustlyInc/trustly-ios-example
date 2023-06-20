//
//  ProductListViewModel.swift
//  TrustlySDKDemoIOS
//
//  Created by Marcos Rivereto on 20/06/23.
//

import Foundation

protocol ProductListViewModelProtocol: ObservableObject {
    var products: [ProductCellView] { get }
    
    func fetchProductsCells()
    
}

class ProductListViewModel: ProductListViewModelProtocol {
    @Published var products: [ProductCellView] = [ProductCellView]()
    
    
    let productsList = [Product(title: "Prime Ultraspeed Stunt", description: "Size 10.5", image:"product", quantity: 1, price: 90.0),
                    Product(title: "Prime Ultraspeed Stunt", description: "Size 10.5", image:"product", quantity: 1, price: 90.0),
                    Product(title: "Prime Ultraspeed Stunt", description: "Size 10.5", image:"product", quantity: 1, price: 90.0),
                    Product(title: "Prime Ultraspeed Stunt", description: "Size 10.5", image:"product", quantity: 1, price: 90.0),
                    Product(title: "Prime Ultraspeed Stunt", description: "Size 10.5", image:"product", quantity: 1, price: 90.0),
                    Product(title: "Prime Ultraspeed Stunt", description: "Size 10.5", image:"product", quantity: 1, price: 90.0),
                    Product(title: "Prime Ultraspeed Stunt", description: "Size 10.5", image:"product", quantity: 1, price: 90.0),
                    Product(title: "Prime Ultraspeed Stunt", description: "Size 10.5", image:"product", quantity: 1, price: 90.0),
                    Product(title: "Prime Ultraspeed Stunt", description: "Size 10.5", image:"product", quantity: 1, price: 90.0),
                    Product(title: "Prime Ultraspeed Stunt", description: "Size 10.5", image:"product", quantity: 1, price: 90.0),
                    Product(title: "Prime Ultraspeed Stunt", description: "Size 10.5", image:"product", quantity: 1, price: 90.0),
                    Product(title: "Prime Ultraspeed Stunt", description: "Size 10.5", image:"product", quantity: 1, price: 90.0),
                    Product(title: "Prime Ultraspeed Stunt", description: "Size 10.5", image:"product", quantity: 1, price: 90.0),
                    Product(title: "Prime Ultraspeed Stunt", description: "Size 10.5", image:"product", quantity: 1, price: 90.0),
                    Product(title: "Prime Ultraspeed Stunt", description: "Size 10.5", image:"product", quantity: 1, price: 90.0),
                    Product(title: "Prime Ultraspeed Stunt", description: "Size 10.5", image:"product", quantity: 1, price: 90.0),
                    Product(title: "Prime Ultraspeed Stunt", description: "Size 10.5", image:"product", quantity: 1, price: 90.0)]
    
    
    func fetchProductsCells() {
        
        self.productsList.forEach {
            products.append(ProductCellView(image: $0.image,
                                            title: $0.title,
                                            description: $0.description,
                                            price: $0.price,
                                            cellType: .catalog))
        }
    }
}
