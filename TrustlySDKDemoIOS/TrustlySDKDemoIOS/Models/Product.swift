//
//  ProductCell.swift
//  TrustlySDKDemoIOS
//
//  Created by Marcos Rivereto on 15/06/23.
//

import Foundation


struct Product: Hashable, Identifiable, Codable {
    var id: String
    let title: String
    let description: String
    let image: String
    var quantity: Int
    let price: Double

}
