//
//  Transaction.swift
//  TrustlySDKDemoIOS
//
//  Created by Marcos Rivereto on 26/06/23.
//

import Foundation


struct Transaction: Hashable, Identifiable {
    var id = UUID()
    let transactionId: String
    let transactionType: String
    let paymentId: String
    var paymentType: String
    let status: String

}
