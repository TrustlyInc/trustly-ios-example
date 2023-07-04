//
//  ProductService.swift
//  TrustlySDKDemoIOS
//
//  Created by Marcos Rivereto on 04/07/23.
//

import Foundation


func getAllProducts() -> [Product] {
    guard let productData = readLocalJSONFile(forName: "products") else { return [Product]() }

    guard let products:[Product] = parse(jsonData: productData) else { return  [Product]() }
    
    return products
}
